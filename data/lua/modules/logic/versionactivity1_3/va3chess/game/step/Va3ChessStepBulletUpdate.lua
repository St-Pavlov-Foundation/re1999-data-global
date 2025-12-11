module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepBulletUpdate", package.seeall)

local var_0_0 = class("Va3ChessStepBulletUpdate", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	arg_1_0._bulletPoolDict = {}
	arg_1_0._launcherId2BulletTweenDict = {}
	arg_1_0._tweenCompleteCount = 0
	arg_1_0._totalTweenCount = arg_1_0.originData and arg_1_0.originData.arrowSteps and #arg_1_0.originData.arrowSteps or 0

	if arg_1_0._totalTweenCount > 0 then
		if arg_1_0._arrowAssetItem and arg_1_0._arrowAssetItem.IsLoadSuccess then
			arg_1_0:beginBulletListTween(arg_1_0._arrowAssetItem, arg_1_0.originData.arrowSteps, Va3ChessEnum.Bullet.Arrow)
		else
			loadAbAsset(Va3ChessEnum.Bullet.Arrow.path, false, arg_1_0.onLoadArrowComplete, arg_1_0)
		end
	else
		arg_1_0:finish()
	end
end

function var_0_0.onLoadArrowComplete(arg_2_0, arg_2_1)
	if arg_2_0._arrowAssetItem then
		arg_2_0._arrowAssetItem:Release()
	end

	arg_2_0._arrowAssetItem = arg_2_1

	if arg_2_1 then
		arg_2_1:Retain()
	end

	arg_2_0:beginBulletListTween(arg_2_0._arrowAssetItem, arg_2_0.originData.arrowSteps, Va3ChessEnum.Bullet.Arrow)
end

function var_0_0.getBulletItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if not arg_3_2 or gohelper.isNil(arg_3_3) then
		return
	end

	local var_3_0
	local var_3_1 = arg_3_0._bulletPoolDict[arg_3_2.path]

	if not var_3_1 then
		var_3_1 = {}
		arg_3_0._bulletPoolDict[arg_3_2.path] = var_3_1
	end

	local var_3_2 = #var_3_1

	if var_3_2 > 0 then
		var_3_0 = var_3_1[var_3_2]
		var_3_1[var_3_2] = nil
	end

	if not var_3_0 and arg_3_1 and arg_3_1.IsLoadSuccess then
		local var_3_3 = gohelper.clone(arg_3_1:GetResource(arg_3_2.path), arg_3_3)

		if not gohelper.isNil(var_3_3) then
			var_3_0 = {
				go = var_3_3,
				dir2GO = {}
			}

			for iter_3_0, iter_3_1 in pairs(Va3ChessEnum.Direction) do
				local var_3_4 = gohelper.findChild(var_3_0.go, string.format("dir_%s", iter_3_1))

				var_3_0.dir2GO[iter_3_1] = var_3_4
			end

			arg_3_0:_setBulletDirGOActive(var_3_0)

			var_3_0.hitEffect = gohelper.findChild(var_3_3, "vx_jian_hit")

			gohelper.setActive(var_3_0.hitEffect, false)
		end
	end

	if var_3_0 and not gohelper.isNil(var_3_0.go) then
		local var_3_5 = var_3_0.go.transform

		if arg_3_4 and arg_3_4.x and arg_3_4.y and arg_3_4.z then
			transformhelper.setLocalPos(var_3_5, arg_3_4.x, arg_3_4.y, arg_3_4.z)
		end

		var_3_5:SetParent(arg_3_3.transform, true)
	else
		var_3_0 = nil

		logError("Va3ChessStepBulletUpdate.getBulletItem error, get bullet item fail")
	end

	return var_3_0
end

function var_0_0._setBulletDirGOActive(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 or not arg_4_1.dir2GO then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_1.dir2GO) do
		gohelper.setActive(iter_4_1, iter_4_0 == arg_4_2)
	end
end

function var_0_0.recycleBulletItem(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 or gohelper.isNil(arg_5_1.go) then
		return
	end

	gohelper.setActive(arg_5_1.go, false)

	local var_5_0 = arg_5_0._bulletPoolDict[arg_5_2]

	if not var_5_0 then
		var_5_0 = {}
		arg_5_0._bulletPoolDict[arg_5_2] = var_5_0
	end

	table.insert(var_5_0, arg_5_1)
end

function var_0_0.disposeBulletItem(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	if arg_6_1.dir2GO then
		for iter_6_0, iter_6_1 in pairs(arg_6_1.dir2GO) do
			iter_6_1 = nil
		end

		arg_6_1.dir2GO = nil
	end

	if not gohelper.isNil(arg_6_1.go) then
		gohelper.destroy(arg_6_1.go)

		arg_6_1.go = nil
	end
end

function var_0_0.beginBulletListTween(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_1 or not arg_7_1.IsLoadSuccess or not arg_7_2 or not arg_7_3 then
		arg_7_0:finish()

		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		local var_7_0 = {}
		local var_7_1
		local var_7_2 = Va3ChessGameController.instance.interacts:get(iter_7_1.launcherId)

		if var_7_2 then
			local var_7_3 = var_7_2:tryGetSceneGO()

			if not gohelper.isNil(var_7_3) then
				local var_7_4 = var_7_3.transform

				var_7_0.x, var_7_0.y, var_7_0.z = transformhelper.getLocalPos(var_7_4)
				var_7_1 = var_7_4.parent and var_7_4.parent.gameObject or nil
			end
		end

		local var_7_5 = arg_7_0:getBulletItem(arg_7_1, arg_7_3, var_7_1, var_7_0)

		if var_7_5 and not gohelper.isNil(var_7_5.go) then
			arg_7_0:playSingleBulletTween(var_7_5, iter_7_1, arg_7_3)
		else
			arg_7_0._totalTweenCount = arg_7_0._totalTweenCount - 1
		end
	end

	if arg_7_0._totalTweenCount <= 0 then
		arg_7_0:finish()
	end
end

function var_0_0.playSingleBulletTween(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2.x1
	local var_8_1 = arg_8_2.y1
	local var_8_2, var_8_3 = Va3ChessGameModel.instance:getGameSize()
	local var_8_4 = Mathf.Clamp(arg_8_2.x2, 0, var_8_2 - 1)
	local var_8_5 = Mathf.Clamp(arg_8_2.y2, 0, var_8_3 - 1)
	local var_8_6 = Va3ChessMapUtils.ToDirection(var_8_0, var_8_1, var_8_4, var_8_5)

	arg_8_0:_setBulletDirGOActive(arg_8_1, var_8_6)

	local var_8_7 = arg_8_2.launcherId
	local var_8_8 = Va3ChessMapUtils.calBulletFlyTime(arg_8_3.speed, var_8_0, var_8_1, var_8_4, var_8_5)
	local var_8_9, var_8_10, var_8_11 = Va3ChessGameController.instance:calcTilePosInScene(var_8_4, var_8_5)
	local var_8_12 = ZProj.TweenHelper.DOLocalMove(arg_8_1.go.transform, var_8_9, var_8_10, var_8_11, var_8_8, function()
		arg_8_0:onSingleTweenComplete(arg_8_2, arg_8_3)
	end, nil, nil, EaseType.Linear)

	AudioMgr.instance:trigger(AudioEnum.chess_activity142.Arrow)

	arg_8_0._launcherId2BulletTweenDict[var_8_7] = {
		tweenId = var_8_12,
		bulletItem = arg_8_1
	}
end

function var_0_0.onSingleTweenComplete(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0
	local var_10_1 = arg_10_1.launcherId
	local var_10_2 = arg_10_0._launcherId2BulletTweenDict[var_10_1]

	if var_10_2 then
		var_10_2.tweenId = nil
		var_10_0 = var_10_2.bulletItem
		var_10_2.bulletItem = nil
	end

	arg_10_0._launcherId2BulletTweenDict[var_10_1] = nil

	local var_10_3 = arg_10_1.targetId

	if var_10_3 and var_10_3 > 0 then
		local var_10_4 = Va3ChessGameController.instance.interacts
		local var_10_5 = var_10_4 and var_10_4:get(var_10_3) or nil

		if var_10_5 and var_10_5.effect and var_10_5.effect.showEffect then
			var_10_5.effect:showEffect(Va3ChessEnum.EffectType.ArrowHit)
		end
	end

	arg_10_0:recycleBulletItem(var_10_0, arg_10_2.path)

	arg_10_0._tweenCompleteCount = arg_10_0._tweenCompleteCount + 1

	if arg_10_0._tweenCompleteCount >= arg_10_0._totalTweenCount and not next(arg_10_0._launcherId2BulletTweenDict) then
		arg_10_0:finish()
	end
end

function var_0_0.dispose(arg_11_0)
	if arg_11_0._arrowAssetItem then
		arg_11_0._arrowAssetItem:Release()

		arg_11_0._arrowAssetItem = nil
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0._launcherId2BulletTweenDict) do
		ZProj.TweenHelper.KillById(iter_11_1.tweenId)

		iter_11_1.tweenId = nil

		arg_11_0:disposeBulletItem(iter_11_1.bulletItem)

		iter_11_1.bulletItem = nil
		arg_11_0._launcherId2BulletTweenDict[iter_11_0] = nil
	end

	arg_11_0._launcherId2BulletTweenDict = {}

	for iter_11_2, iter_11_3 in pairs(arg_11_0._bulletPoolDict) do
		for iter_11_4, iter_11_5 in ipairs(iter_11_3) do
			arg_11_0:disposeBulletItem(iter_11_5)

			iter_11_3[iter_11_4] = nil
		end

		arg_11_0._bulletPoolDict[iter_11_2] = nil
	end

	arg_11_0._bulletPoolDict = {}
	arg_11_0._tweenCompleteCount = 0
	arg_11_0._totalTweenCount = 0

	var_0_0.super.dispose(arg_11_0)
end

return var_0_0
