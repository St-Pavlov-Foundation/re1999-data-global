module("modules.logic.playercard.model.PlayerCardThemeListModel", package.seeall)

slot0 = class("PlayerCardThemeListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._tempId = nil
end

function slot0.reInit(slot0)
	slot0._tempId = nil
end

function slot0.initTheme(slot0, slot1)
	slot0._curId = slot1
	slot0._tempId = slot1
end

function slot0.refreshList(slot0)
	slot1 = {}

	if PlayerCardConfig.instance:getCardThemeList() then
		for slot6, slot7 in ipairs(slot2) do
			table.insert(slot1, {
				id = slot7.id,
				config = slot7
			})
		end
	end

	table.sort(slot1, SortUtil.keyLower("id"))
	slot0:setList(slot1)
end

function slot0.selectTheme(slot0, slot1)
	if not slot1 or slot1 == slot0._tempId then
		return
	end

	slot0._tempId = slot1

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SwitchTheme, slot1)
end

function slot0.getSelectTheme(slot0)
	return slot0._tempId
end

function slot0.getUsingTheme(slot0)
	return slot0._curId
end

slot0.instance = slot0.New()

return slot0
