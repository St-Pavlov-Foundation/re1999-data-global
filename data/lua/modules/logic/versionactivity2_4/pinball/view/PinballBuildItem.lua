module("modules.logic.versionactivity2_4.pinball.view.PinballBuildItem", package.seeall)

slot0 = class("PinballBuildItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goselect = gohelper.findChild(slot1, "#go_select")
	slot0._imageicon = gohelper.findChildSingleImage(slot1, "#image_icon")
	slot0._godone = gohelper.findChild(slot1, "#go_done")
	slot0._golock = gohelper.findChild(slot1, "#go_lock")
	slot0._txtname = gohelper.findChildTextMesh(slot1, "#txt_name")
end

function slot0.initData(slot0, slot1, slot2)
	slot0._data = slot1
	slot0._index = slot2
	slot0._txtname.text = slot0._data.name

	gohelper.setActive(slot0._golock, slot0:isLock())
	gohelper.setActive(slot0._godone, slot0:isDone())
end

function slot0.isDone(slot0)
	if slot0._data.limit <= PinballModel.instance:getBuildingNum(slot0._data.id) then
		return true
	end

	return false
end

function slot0.isLock(slot0, slot1)
	if string.nilorempty(slot0._data.condition) then
		return false
	end

	for slot7, slot8 in pairs(GameUtil.splitString2(slot2, true)) do
		if slot8[1] == PinballEnum.ConditionType.Talent then
			if not PinballModel.instance:getTalentMo(slot8[2]) then
				if slot1 then
					GameFacade.showToast(ToastEnum.Act178TalentCondition, lua_activity178_talent.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot10].name)
				end

				return true
			end
		elseif slot9 == PinballEnum.ConditionType.Score and PinballModel.instance.maxProsperity < slot8[2] then
			if slot1 then
				GameFacade.showToast(ToastEnum.Act178ScoreCondition, PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot10))
			end

			return true
		end
	end

	return false
end

function slot0.setSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)

	slot3 = 1

	if not slot0:isDone() and not slot1 then
		slot3 = 1
	elseif slot2 and not slot1 then
		slot3 = 2
	elseif slot2 and slot1 then
		slot3 = 3
	elseif not slot2 and slot1 then
		slot3 = 4
	end

	slot0._imageicon:LoadImage(string.format("singlebg/v2a4_tutushizi_singlebg/building/%s_%s.png", slot0._data.icon, slot3))
end

return slot0
