module("modules.logic.handbook.view.HandbookEquipViewContainer", package.seeall)

slot0 = class("HandbookEquipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, HandbookEquipView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

function slot0.onContainerInit(slot0)
	slot0:checkConfigValid()
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	slot0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

function slot0.checkConfigValid(slot0)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	slot1 = {
		[slot6.equipId] = true
	}

	for slot5, slot6 in ipairs(lua_handbook_equip.configList) do
		-- Nothing
	end

	for slot6, slot7 in ipairs(lua_equip.configList) do
		-- Nothing
	end

	for slot6, slot7 in pairs({
		[slot7.id] = true
	}) do
		if not slot1[slot6] and string.nilorempty(lua_equip.configDict[slot6].canShowHandbook) then
			logError("图鉴心相表未配置装备id : " .. slot6)
		end
	end
end

return slot0
