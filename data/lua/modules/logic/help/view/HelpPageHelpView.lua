module("modules.logic.help.view.HelpPageHelpView", package.seeall)

slot0 = class("HelpPageHelpView", HelpView)

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, HelpEvent.UIPageTabSelectChange, slot0._onVoideFullScreenChange, slot0)
	end

	slot0._showParam = {}
end

function slot0._refreshHelpPage(slot0)
	if slot0._helpItems then
		for slot4, slot5 in pairs(slot0._helpItems) do
			slot5:destroy()
			gohelper.destroy(slot5._go)
		end
	end

	slot0._helpItems = {}

	slot0:_refreshView()
end

function slot0.setSelectItem(slot0)
	for slot5 = 1, #slot0._pagesCo do
		if not slot0._selectItems[slot5] then
			slot8 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goslider, "HelpSelectItem")
			slot6 = HelpSelectItem.New()

			slot6:init({
				go = slot8,
				index = slot5,
				config = slot0._pagesCo[slot5],
				pos = 55 * (slot5 - 0.5 * (#slot0._pagesCo + 1))
			})

			slot6._goTrs = slot8.transform

			table.insert(slot0._selectItems, slot6)
		else
			transformhelper.setLocalPos(slot6._goTrs, slot7, 0, 0)
			gohelper.setActive(slot6._go, true)
		end

		slot6:updateItem()
	end

	for slot5 = #slot0._pagesCo + 1, #slot0._selectItems do
		gohelper.setActive(slot0._selectItems[slot5]._go, false)
	end
end

function slot0._onlyShowLastGuideQuitBtn(slot0)
	for slot4, slot5 in ipairs(slot0._helpItems) do
		slot5:showQuitBtn(false)
	end
end

function slot0._refreshView(slot0)
	slot0._helpId = slot0.viewParam.id
	slot0._pageId = slot0.viewParam.pageId

	if slot0.viewParam.guideId then
		slot0._helpId = tonumber(slot0.viewParam.viewParam)
		slot0._matchGuideId = tonumber(slot0.viewParam.guideId)
		slot0._matchAllPage = slot0.viewParam.matchAllPage
	end

	if not slot0.viewParam.openFromGuide then
		slot0:addEventCb(GuideController.instance, GuideEvent.FinishStep, slot0._onFinishGuideStep, slot0)
	end

	slot0._pagesCo = {}

	if slot0._helpId then
		if not HelpConfig.instance:getHelpCO(slot0._helpId) then
			logError("请检查帮助说明配置" .. tostring(slot0._helpId) .. "相关配置是否完整！")
		end

		if #string.split(slot1.page, "#") < 1 then
			logError("请检查帮助界面" .. tostring(slot0._helpId) .. "相关配置是否完整！")

			return
		end

		HelpModel.instance:setTargetPageIndex(1)

		for slot6 = 1, #slot2 do
			table.insert(slot0._pagesCo, HelpConfig.instance:getHelpPageCo(tonumber(slot2[slot6])))
		end
	elseif slot0._pageId then
		HelpModel.instance:setTargetPageIndex(1)
		table.insert(slot0._pagesCo, HelpConfig.instance:getHelpPageCo(slot0._pageId))
	end

	if #slot0._pagesCo < 1 then
		logError(string.format("help view(helpId : %s) not found can show pages", slot0._helpId))

		return
	end

	slot0:setSelectItem()
	slot0:setHelpItem()
	slot0:setBtnItem()
	slot0:_onlyShowLastGuideQuitBtn()
	NavigateMgr.instance:addEscape(ViewName.HelpView, slot0.closeThis, slot0)
	FightAudioMgr.instance:obscureBgm(true)
end

function slot0._onVoideFullScreenChange(slot0, slot1)
	slot0:setPageTabCfg(slot1)
end

function slot0.setPageTabCfg(slot0, slot1)
	if slot1 and slot1.showType == HelpEnum.PageTabShowType.HelpView and slot0._curShowHelpId ~= slot1.helpId then
		slot0._curShowHelpId = slot1.helpId
		slot0._showParam.id = slot1.helpId
		slot0.viewParam = slot0._showParam

		slot0:_refreshHelpPage()
	end
end

return slot0
