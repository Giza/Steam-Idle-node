var username1 = '';
var password1 = '';
//var authCode1 = '';
var args = process.argv.slice(2);
var fs = require('fs');
var steam = require('steam');
var request = require('request');
var sentryFile = username1 + ".ssfn";
var sentry = undefined;
//for authCode 
var readline   = require('readline');
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});
//sentryFile read
if (fs.existsSync(sentryFile)) {
    sentry = fs.readFileSync(sentryFile);
}
// Update sentryFile
function updateSentry (buffer) {
    console.log(buffer);
    fs.writeFile(sentryFile, buffer);
    exit();
}
//start
function createIdler(userinfo, timer){
	var startIdleFlag = false;
	var preTimer = 110*60*1000;
    var bot = new steam.SteamClient();
    userinfo.bot = bot;
	//check acc
    bot.on('loggedOn', function() {
        bot.setPersonaState(steam.EPersonaState.Offline);
        canTrade = false;
        console.log('Logged in|Вход как ' + userinfo.username);
    });
	//add sentryFile
    bot.on('sentry', function(sentryHash) {
		console.log('Received sentry file.||Получение sentry файла');
		fs.writeFile(sentryFile,sentryHash,function(err) {
			if(err){
			  console.log(err);
			} else {
			  console.log('Saved sentry file to disk.||Сохраненные sentry файла на диск.');
		}});
	});
	//errors
    bot.on('error', function(e) {
		console.log('ERROR - Logon failed||ОШИБКА - Вход невыполнен');
		if (e.eresult == steam.EResult.InvalidPassword)
		{
		console.log('Reason: invalid password||неверный пароль');
		}
		else if (e.eresult == steam.EResult.AlreadyLoggedInElsewhere)
		{
		console.log('Reason: already logged in elsewhere||выполнен вход с другого устройства');
		}
		else if (e.eresult == steam.EResult.AccountLogonDenied)
		{
		console.log('Reason: logon denied - steam guard needed||вход запрещен - нужен steam guard');
		rl.question('Steam Guard Code: ', function(code) {
            // Try logging on again
            bot.logOn({
                accountName: userinfo.username,
                password: userinfo.password,
                authCode: code
            });
		});
		}
    });
	//start startIdle 2h
    function startIdle(){
		if (startIdleFlag) return;
        var req = request.defaults({jar: userinfo.jar});
        req.get('http://steamcommunity.com/my/badges/', function (err, res, body) {
            if (body) {
				var b = /<a class="btn_green_white_innerfade btn_small_thin" href="steam:\/\/run\/(\d+)">/g;
				var dropcard = /<span class="progress_info_bold">(\d+) card drop(.*?)remaining<\/span>/g;
				var gamename = /You can get (.*?) more trading card(.*?)by playing (.*?).	<\/div>/g;
				var nickname = body.match(/data-miniprofile="(.*?)">(.*?)<\/a>/);
				if (b) {
							var myArray, result = [];
							while ((myArray = b.exec(body)) != null){
							result.push(parseInt(myArray[1]));
							}
							var myArray2, dropcard_result = [];
							while ((myArray2 = dropcard.exec(body)) != null){
							dropcard_result.push(parseInt(myArray2[1]));
							}
							var myArray3, gamename_result = [];
							while ((myArray3 = gamename.exec(body)) != null){
							gamename_result.push(String(myArray3[3]));
							}	
				    //console.log(userinfo.username);
					console.log("||Profile: " + nickname[2]);
					console.log("||Idling all games: " + gamename_result);
					console.log("||Количество оставшихся карт: " + dropcard_result);
					bot.gamesPlayed(result);
                }
            }
            var now = new Date();                
            console.log(now.getHours()+':'+now.getMinutes()+':'+now.getSeconds());
        });
		startIdleFlag = true;
    }
	//start idle default
	function newStartIdle(){
        var req = request.defaults({jar: userinfo.jar});
        req.get('http://steamcommunity.com/my/badges/', function (err, res, body) {
            if (body) {
				var b = body.match(/<a class="btn_green_white_innerfade btn_small_thin" href="steam:\/\/run\/(\d+)">/);
				var gamename = body.match(/You can get (.*?) more trading card(.*?)by playing (.*?).	<\/div>/);
				var dropcard = body.match(/<span class="progress_info_bold">(\d+) card drop(.*?)remaining<\/span>/);
				if (b) {
				    //console.log(userinfo.username);
					console.log("||Profile: " + nickname[2]);
                    console.log("||Idling game: " + gamename[3]);
					console.log("||Количество оставшихся карточек на игру: " + dropcard[1]);
                    bot.gamesPlayed([b[1]]);
                }
            }
            var now = new Date();                
            console.log(now.getHours()+':'+now.getMinutes()+':'+now.getSeconds());
        });
    }	
	//start webSessionID
    bot.on('webSessionID', function (sessionID) {
        userinfo.jar = request.jar(),
        userinfo.sessionID = sessionID;
        bot.webLogOn(function(cookies) {
            cookies.forEach(function(cookie) {
                userinfo.jar.setCookie(request.cookie(cookie), 'http://steamcommunity.com');
                userinfo.jar.setCookie(request.cookie(cookie), 'http://store.steampowered.com');
                userinfo.jar.setCookie(request.cookie(cookie), 'https://store.steampowered.com');
            });
            userinfo.jar.setCookie(request.cookie("Steam_Language=english"), 'http://steamcommunity.com');
            startIdle();
			setTimeout(function () {
			setInterval(newStartIdle, timer);
			}, preTimer);
        });
    });
	//log chat
	bot.on('friendMsg', function(user, message, type) {
		if(type == steam.EChatEntryType.ChatMsg) {
			// show chat messages in window
			var now = new Date();
			console.log(now.toLocaleTimeString() + ": " + user + ": " + message);
			// log chat messages
			fs.appendFile(username1 + "_incoming.txt", user + ": " + message + "\n");
			// auto-respond to incoming messages
			bot.sendMessage(user, "i'm not here right now.||Меня нет на месте.", steam.EChatEntryType.ChatMsg);
		}
	});
	//login acc
    bot.logOn({
        accountName: userinfo.username,
        password: userinfo.password,
        authCode: userinfo.authCode,
        shaSentryfile: sentry
    });
}
createIdler({
    username: username1,
    password: password1,
    //authCode: authCode1
}, (10*60*1000));
