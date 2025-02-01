module("modules.logic.help.model.HelpModel", package.seeall)

slot0 = class("HelpModel", BaseModel)

function slot0.onInit(slot0)
	slot0._targetPageIndex = 0
end

function slot0.reInit(slot0)
	slot0._targetPageIndex = 0
end

function slot0.setTargetPageIndex(slot0, slot1)
	slot0._targetPageIndex = slot1
end

function slot0.getTargetPageIndex(slot0)
	return slot0._targetPageIndex
end

function slot0.updateShowedHelpId(slot0)
	slot0.showedHelpIdList = string.splitToNumber(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ShowHelpIds), "#")
end

function slot0.isShowedHelp(slot0, slot1)
	if not slot1 then
		return false
	end

	for slot5, slot6 in ipairs(slot0.showedHelpIdList) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.setShowedHelp(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0:isShowedHelp(slot1) then
		return
	end

	table.insert(slot0.showedHelpIdList, slot1)
	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.ShowHelpIds, table.concat(slot0.showedHelpIdList, "#"))
end

slot0.instance = slot0.New()

return slot0
