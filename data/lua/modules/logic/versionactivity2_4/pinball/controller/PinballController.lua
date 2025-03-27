module("modules.logic.versionactivity2_4.pinball.controller.PinballController", package.seeall)

slot0 = class("PinballController", BaseController)

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._getInfo, slot0)
	slot0:registerCallback(PinballEvent.GuideAddRes, slot0._guideAddRes, slot0)
end

function slot0._getInfo(slot0, slot1)
	if slot1 and slot1 ~= VersionActivity2_4Enum.ActivityId.Pinball then
		return
	end

	if PinballModel.instance:isOpen() then
		Activity178Rpc.instance:sendGetAct178Info(VersionActivity2_4Enum.ActivityId.Pinball)
	end
end

function slot0.openMainView(slot0)
	ViewMgr.instance:openView(ViewName.PinballCityView)
end

function slot0.sendGuideMainLv(slot0)
	slot0:dispatchEvent(PinballEvent.GuideMainLv, uv0._checkMainLv)
end

function slot0._checkMainLv(slot0)
	if not tonumber(slot0) then
		return
	end

	return slot1 <= PinballModel.instance:getScoreLevel()
end

function slot0._guideAddRes(slot0)
	Activity178Rpc.instance:sendAct178GuideAddGrain(VersionActivity2_4Enum.ActivityId.Pinball)
end

function slot0.removeBuilding(slot0, slot1)
	if not PinballModel.instance:getBuildingInfo(slot1) then
		return
	end

	GameUtil.setDefaultValue({}, 0)

	for slot7 = 1, slot2.level do
		if lua_activity178_building.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot2.configId][slot7] and not string.nilorempty(slot8.cost) then
			for slot13, slot14 in pairs(GameUtil.splitString2(slot8.cost, true)) do
				slot3[slot14[1]] = slot3[slot14[1]] + slot14[2]
			end
		end
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot3) do
		if lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot8] then
			table.insert(slot4, GameUtil.getSubPlaceholderLuaLang(luaLang("PinballController_removeBuilding"), {
				slot10.name,
				slot9
			}))
		end
	end

	slot0._tempIndex = slot1

	GameFacade.showMessageBox(MessageBoxIdDefine.PinballRemoveBuilding, MsgBoxEnum.BoxType.Yes_No, slot0._realRemoveBuilding, nil, , slot0, nil, , table.concat(slot4, luaLang("PinballController_sep")))
end

function slot0._realRemoveBuilding(slot0)
	if not PinballModel.instance:getBuildingInfo(slot0._tempIndex) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio5)
	Activity178Rpc.instance:sendAct178Build(VersionActivity2_4Enum.ActivityId.Pinball, slot1.configId, PinballEnum.BuildingOperType.Remove, slot0._tempIndex)
end

slot0.instance = slot0.New()

return slot0
