var oiiaoiia = false;
var anamorphiceffect = new CustomShader("anamorphic effects");
anamorphiceffect.intensity = 10;
anamorphiceffect.brightness = 0.06;
var anamorphiceffecttween:FlxTween = null;

var discoCat = new FunkinSprite(0, 0);
discoCat.frames = Paths.getFrames("kitty");
discoCat.animation.addByPrefix("idle", "spinner", 260);
discoCat.animation.play("idle");
discoCat.zoomFactor = 0;
discoCat.scrollFactor.set();
discoCat.alpha = 0;

var theLegitBG = new FunkinSprite().makeSolid(1280, 720, 0xFF000000);
theLegitBG.alpha = 0;
theLegitBG.zoomFactor = 0;
theLegitBG.scrollFactor.set();


function postCreate() {
	insert(0, theLegitBG);
	add(discoCat);
	discoCat.setGraphicSize(1280, 720);
	discoCat.screenCenter();
    FlxG.camera.bgColor = 0xFFFFFFFF;
    FlxG.camera.followLerp = 1.0;
    FlxG.camera.addShader(anamorphiceffect);
    //FlxG.camera.snapToTarget();
    //FlxG.camera.follow();
    FlxG.sound.play(Paths.sound("begin"));
	dad.playAnim("idle alt");
	dad.animation.curAnim.frameRate = 100;
	new FlxTimer().start(1.7, function() {
		dad.playAnim("idle");
		new FlxTimer().start(1.1, function() {
            FlxTween.tween(FlxG.camera, {zoom: 1.3}, 8, {ease: FlxEase.sineInOut});
            defaultCamZoom = 1.3;
            FlxTween.tween(FlxG.camera.scroll, {y: FlxG.camera.scroll.y + 50}, 14, {ease: FlxEase.sineInOut});
            FlxG.camera.follow();
			dad.playAnim("idle alt");
			dad.animation.curAnim.frameRate = 60;
			new FlxTimer().start(2.1, function() {
				dad.playAnim("idle");
				new FlxTimer().start(.4, function() {
					oiiaoiia = true;
					startCountdown();
					startTimer.cancel();
					FlxTween.tween(camHUD, {alpha: 1}, 0.1);
					FlxG.camera.follow();
				});
			});
		});
	});
}

function onStartCountdown(event) {
	if (!oiiaoiia) {
        event.cancel();
        return;
    }
}

function flarePlay() {
	FlxTween.num(0, 100, 0.1, {ease: FlxEase.sineOut}, function(v){
		anamorphiceffect.intensity = v;
	})
	.then(FlxTween.num(100, 10, 0.5, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(10, 80, 0.3, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(80, 30, 0.3, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 80, 0.3, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(80, 30, 0.3, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 100, 0.3, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}));
}

function beatHit() {
	switch(curBeat) {
		case 0,32: flarePlay();
		
		case 4:
			FlxTween.cancelTweensOf(FlxG.camera);
			defaultCamZoom = 1;

		case 16:
			FlxTween.tween(discoCat, {alpha: 0.3}, 0.2);

		case 18:
			FlxTween.tween(discoCat, {alpha: 0}, 0.2);
	}
}

function stepHit() {
	if (curStep > 143 && curStep < 270) {
		FlxTween.completeTweensOf(theLegitBG);
		FlxTween.tween(theLegitBG, {alpha: 1-((270 - curStep) / 127)}, (Conductor.stepCrochet/1000)/2)
		.then(FlxTween.tween(theLegitBG, {alpha: 0}, (Conductor.stepCrochet/1000)/2));
	}
	if (curStep == 270) FlxG.camera.bgColor = 0;
}