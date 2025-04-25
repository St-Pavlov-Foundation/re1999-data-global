module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessEffectComp", package.seeall)

slot0 = class("AutoChessEffectComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goEffPointU = gohelper.findChild(slot1, "eff_up")
	slot0.goEffPointD = gohelper.findChild(slot1, "eff_down")
	slot0.effectGoDic = slot0:getUserDataTb_()
end

function slot0.playEffect(slot0, slot1)
	if lua_auto_chess_effect.configDict[slot1] then
		if slot2.soundId ~= 0 then
			AudioMgr.instance:trigger(slot2.soundId)
		end

		if not string.nilorempty(slot2.offset) then
			slot3 = AutoChessEnum.EffectPos[slot2.position] - string.splitToVector2(slot2.offset, ",")
		end

		slot0:activeEffect(slot2, slot2.nameUp, slot3, slot0.goEffPointU)
		slot0:activeEffect(slot2, slot2.nameDown, slot3, slot0.goEffPointD)

		return slot2.duration
	end

	return 0
end

function slot0.activeEffect(slot0, slot1, slot2, slot3, slot4)
	if string.nilorempty(slot2) then
		return
	end

	if slot0.effectGoDic[slot2] then
		gohelper.setActive(slot5, true)
	else
		slot5 = gohelper.create2d(slot4, slot2)

		recthelper.setAnchor(slot5.transform, slot3.x, slot3.y)

		slot0.effectGoDic[slot2] = slot5

		AutoChessEffectMgr.instance:getEffectRes(slot2, slot5)
	end

	if slot1.loop ~= 1 then
		TaskDispatcher.runDelay(function ()
			gohelper.setActive(uv0, false)
		end, nil, slot1.duration + 0.2)
	end
end

function slot0.removeEffect(slot0, slot1)
	if lua_auto_chess_effect.configDict[slot1] and slot2.loop == 1 then
		if not string.nilorempty(slot2.nameUp) then
			gohelper.setActive(slot0.effectGoDic[slot3], false)
		end

		if not string.nilorempty(slot2.nameDown) then
			gohelper.setActive(slot0.effectGoDic[slot3], false)
		end
	end
end

function slot0.moveEffect(slot0, slot1, slot2, slot3)
	slot4 = slot0.effectGoDic[slot1]
	slot2 = recthelper.rectToRelativeAnchorPos(slot2, slot4.transform.parent)

	if slot4 then
		ZProj.TweenHelper.DOAnchorPos(slot4.transform, slot2.x, slot2.y, slot3, nil, , , EaseType.Linear)
	else
		logError(string.format("异常:未加载特效%s", slot1))
	end
end

function slot0.hideAll(slot0)
	for slot4, slot5 in pairs(slot0.effectGoDic) do
		gohelper.setActive(slot5, false)
	end
end

return slot0
