module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepBulletUpdate", package.seeall)

slot0 = class("Va3ChessStepBulletUpdate", Va3ChessStepBase)

function slot0.start(slot0)
	slot0._bulletPoolDict = {}
	slot0._launcherId2BulletTweenDict = {}
	slot0._tweenCompleteCount = 0
	slot0._totalTweenCount = slot0.originData and slot0.originData.arrowSteps and #slot0.originData.arrowSteps or 0

	if slot0._totalTweenCount > 0 then
		if slot0._arrowAssetItem and slot0._arrowAssetItem.IsLoadSuccess then
			slot0:beginBulletListTween(slot0._arrowAssetItem, slot0.originData.arrowSteps, Va3ChessEnum.Bullet.Arrow)
		else
			loadAbAsset(Va3ChessEnum.Bullet.Arrow.path, false, slot0.onLoadArrowComplete, slot0)
		end
	else
		slot0:finish()
	end
end

function slot0.onLoadArrowComplete(slot0, slot1)
	if slot0._arrowAssetItem then
		slot0._arrowAssetItem:Release()
	end

	slot0._arrowAssetItem = slot1

	slot0:beginBulletListTween(slot0._arrowAssetItem, slot0.originData.arrowSteps, Va3ChessEnum.Bullet.Arrow)
end

function slot0.getBulletItem(slot0, slot1, slot2, slot3, slot4)
	if not slot2 or gohelper.isNil(slot3) then
		return
	end

	slot5 = nil

	if not slot0._bulletPoolDict[slot2.path] then
		slot0._bulletPoolDict[slot2.path] = {}
	end

	if #slot6 > 0 then
		slot5 = slot6[slot7]
		slot6[slot7] = nil
	end

	if not slot5 and slot1 and slot1.IsLoadSuccess then
		slot1:Retain()

		if not gohelper.isNil(gohelper.clone(slot1:GetResource(slot2.path), slot3)) then
			slot5 = {
				go = slot8,
				dir2GO = {}
			}

			for slot12, slot13 in pairs(Va3ChessEnum.Direction) do
				slot5.dir2GO[slot13] = gohelper.findChild(slot5.go, string.format("dir_%s", slot13))
			end

			slot0:_setBulletDirGOActive(slot5)

			slot5.hitEffect = gohelper.findChild(slot8, "vx_jian_hit")

			gohelper.setActive(slot5.hitEffect, false)
		end
	end

	if slot5 and not gohelper.isNil(slot5.go) then
		slot8 = slot5.go.transform

		if slot4 and slot4.x and slot4.y and slot4.z then
			transformhelper.setLocalPos(slot8, slot4.x, slot4.y, slot4.z)
		end

		slot8:SetParent(slot3.transform, true)
	else
		slot5 = nil

		logError("Va3ChessStepBulletUpdate.getBulletItem error, get bullet item fail")
	end

	return slot5
end

function slot0._setBulletDirGOActive(slot0, slot1, slot2)
	if not slot1 or not slot1.dir2GO then
		return
	end

	for slot6, slot7 in pairs(slot1.dir2GO) do
		gohelper.setActive(slot7, slot6 == slot2)
	end
end

function slot0.recycleBulletItem(slot0, slot1, slot2)
	if not slot1 or gohelper.isNil(slot1.go) then
		return
	end

	gohelper.setActive(slot1.go, false)

	if not slot0._bulletPoolDict[slot2] then
		slot0._bulletPoolDict[slot2] = {}
	end

	table.insert(slot3, slot1)
end

function slot0.disposeBulletItem(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1.dir2GO then
		for slot5, slot6 in pairs(slot1.dir2GO) do
			slot6 = nil
		end

		slot1.dir2GO = nil
	end

	if not gohelper.isNil(slot1.go) then
		gohelper.destroy(slot1.go)

		slot1.go = nil
	end
end

function slot0.beginBulletListTween(slot0, slot1, slot2, slot3)
	if not slot1 or not slot1.IsLoadSuccess or not slot2 or not slot3 then
		slot0:finish()

		return
	end

	for slot7, slot8 in ipairs(slot2) do
		slot9 = {
			x = transformhelper.getLocalPos(slot13)
		}
		slot10 = nil

		if Va3ChessGameController.instance.interacts:get(slot8.launcherId) and not gohelper.isNil(slot11:tryGetSceneGO()) then
			slot13 = slot12.transform
			slot10 = slot13.parent and slot13.parent.gameObject or nil
		end

		if slot0:getBulletItem(slot1, slot3, slot10, slot9) and not gohelper.isNil(slot12.go) then
			slot0:playSingleBulletTween(slot12, slot8, slot3)
		else
			slot0._totalTweenCount = slot0._totalTweenCount - 1
		end
	end

	if slot0._totalTweenCount <= 0 then
		slot0:finish()
	end
end

function slot0.playSingleBulletTween(slot0, slot1, slot2, slot3)
	slot4 = slot2.x1
	slot5 = slot2.y1
	slot6, slot7 = Va3ChessGameModel.instance:getGameSize()
	slot8 = Mathf.Clamp(slot2.x2, 0, slot6 - 1)
	slot9 = Mathf.Clamp(slot2.y2, 0, slot7 - 1)

	slot0:_setBulletDirGOActive(slot1, Va3ChessMapUtils.ToDirection(slot4, slot5, slot8, slot9))

	slot13, slot14, slot15 = Va3ChessGameController.instance:calcTilePosInScene(slot8, slot9)

	AudioMgr.instance:trigger(AudioEnum.chess_activity142.Arrow)

	slot0._launcherId2BulletTweenDict[slot2.launcherId] = {
		tweenId = ZProj.TweenHelper.DOLocalMove(slot1.go.transform, slot13, slot14, slot15, Va3ChessMapUtils.calBulletFlyTime(slot3.speed, slot4, slot5, slot8, slot9), function ()
			uv0:onSingleTweenComplete(uv1, uv2)
		end, nil, , EaseType.Linear),
		bulletItem = slot1
	}
end

function slot0.onSingleTweenComplete(slot0, slot1, slot2)
	slot3 = nil

	if slot0._launcherId2BulletTweenDict[slot1.launcherId] then
		slot5.tweenId = nil
		slot3 = slot5.bulletItem
		slot5.bulletItem = nil
	end

	slot0._launcherId2BulletTweenDict[slot4] = nil

	if slot1.targetId and slot6 > 0 and (Va3ChessGameController.instance.interacts and slot7:get(slot6) or nil) and slot8.effect and slot8.effect.showEffect then
		slot8.effect:showEffect(Va3ChessEnum.EffectType.ArrowHit)
	end

	slot0:recycleBulletItem(slot3, slot2.path)

	slot0._tweenCompleteCount = slot0._tweenCompleteCount + 1

	if slot0._totalTweenCount <= slot0._tweenCompleteCount and not next(slot0._launcherId2BulletTweenDict) then
		slot0:finish()
	end
end

function slot0.dispose(slot0)
	if slot0._arrowAssetItem then
		slot0._arrowAssetItem:Release()

		slot0._arrowAssetItem = nil
	end

	for slot4, slot5 in pairs(slot0._launcherId2BulletTweenDict) do
		ZProj.TweenHelper.KillById(slot5.tweenId)

		slot5.tweenId = nil

		slot0:disposeBulletItem(slot5.bulletItem)

		slot5.bulletItem = nil
		slot0._launcherId2BulletTweenDict[slot4] = nil
	end

	slot0._launcherId2BulletTweenDict = {}

	for slot4, slot5 in pairs(slot0._bulletPoolDict) do
		for slot9, slot10 in ipairs(slot5) do
			slot0:disposeBulletItem(slot10)

			slot5[slot9] = nil
		end

		slot0._bulletPoolDict[slot4] = nil
	end

	slot0._bulletPoolDict = {}
	slot0._tweenCompleteCount = 0
	slot0._totalTweenCount = 0

	uv0.super.dispose(slot0)
end

return slot0
