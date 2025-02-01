module("modules.logic.activity.controller.ActivityEnterMgr", package.seeall)

slot0 = class("ActivityEnterMgr", BaseController)

function slot0.init(slot0)
	slot0:loadEnteredActivityDict()
end

function slot0.enterActivityByList(slot0, slot1)
	slot2 = false

	for slot6, slot7 in ipairs(slot1) do
		if not slot0:isEnteredActivity(slot7) then
			slot2 = true

			table.insert(slot0.enteredActList, slot0:getActId(slot7))
		end
	end

	if slot2 then
		PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnteredActKey), table.concat(slot0.enteredActList, ";"))
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
	end
end

function slot0.enterActivity(slot0, slot1)
	if slot0:isEnteredActivity(slot1) then
		return
	end

	table.insert(slot0.enteredActList, slot0:getActId(slot1))
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnteredActKey), table.concat(slot0.enteredActList, ";"))
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
end

function slot0.loadEnteredActivityDict(slot0)
	slot0.enteredActList = {}

	if string.nilorempty(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnteredActKey), "")) then
		return
	end

	slot0.enteredActList = string.splitToNumber(slot1, ";")
end

function slot0.isEnteredActivity(slot0, slot1)
	return tabletool.indexOf(slot0.enteredActList, slot0:getActId(slot1))
end

function slot0.getActId(slot0, slot1)
	if ActivityConfig.instance:getActivityCo(slot1) and slot2.isRetroAcitivity == 1 then
		slot1 = -slot1
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
