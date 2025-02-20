module("modules.logic.help.view.HelpView", package.seeall)

slot0 = class("HelpView", BaseView)

function slot0.onInitView(slot0)
	slot0._goslider = gohelper.findChild(slot0.viewGO, "#go_slider")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_content")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_left")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_right")
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "#go_scroll")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
end

function slot0._btnleftOnClick(slot0)
	HelpModel.instance:setTargetPageIndex(HelpModel.instance:getTargetPageIndex() - 1)
	slot0:selectHelpItem()
end

function slot0._btnrightOnClick(slot0)
	HelpModel.instance:setTargetPageIndex(HelpModel.instance:getTargetPageIndex() + 1)
	slot0:selectHelpItem()
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(slot0._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	slot0._selectItems = {}
	slot0._helpItems = {}
	slot0._space = recthelper.getWidth(slot0.viewGO.transform) + 80
	slot0._scroll = SLFramework.UGUI.UIDragListener.Get(slot0._goscroll)

	slot0._scroll:AddDragBeginListener(slot0._onScrollDragBegin, slot0)
	slot0._scroll:AddDragEndListener(slot0._onScrollDragEnd, slot0)

	slot0._viewClick = gohelper.getClick(slot0._gocontent)

	slot0._viewClick:AddClickListener(slot0._onClickView, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0._onScreenResize(slot0)
	slot0._space = recthelper.getWidth(slot0.viewGO.transform) + 80

	if slot0._helpItems then
		for slot5 = 1, #slot0._helpItems do
			slot0._helpItems[slot5]:updatePos(slot0._space * (slot5 - 1))
		end
	end

	recthelper.setAnchorX(slot0._gocontent.transform, (1 - HelpModel.instance:getTargetPageIndex()) * slot0._space)
end

function slot0._onScrollDragBegin(slot0, slot1, slot2)
	slot0._scrollStartPos = slot2.position
end

function slot0._onScrollDragEnd(slot0, slot1, slot2)
	slot3 = slot2.position

	if math.abs(slot3.x - slot0._scrollStartPos.x) < math.abs(slot3.y - slot0._scrollStartPos.y) then
		return
	end

	if slot4 > 100 and slot0._btnleft.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		HelpModel.instance:setTargetPageIndex(HelpModel.instance:getTargetPageIndex() - 1)
		slot0:selectHelpItem()
	elseif slot4 < -100 and slot0._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		HelpModel.instance:setTargetPageIndex(HelpModel.instance:getTargetPageIndex() + 1)
		slot0:selectHelpItem()
	end
end

function slot0._onClickView(slot0)
	if slot0.viewParam.guideId then
		slot0:_btnrightOnClick()
	end
end

function slot0.onUpdateParam(slot0)
	if slot0._helpItems then
		for slot4, slot5 in pairs(slot0._helpItems) do
			slot5:destroy()
			gohelper.destroy(slot5._go)
		end
	end

	slot0._helpItems = {}

	slot0:_refreshView()
end

function slot0.onOpen(slot0)
	slot0:_refreshView()
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

		slot6 = 1

		HelpModel.instance:setTargetPageIndex(slot6)

		for slot6 = 1, #slot2 do
			slot7 = HelpConfig.instance:getHelpPageCo(tonumber(slot2[slot6]))

			if slot0._matchAllPage then
				if HelpController.instance:canShowPage(slot7) or slot7.unlockGuideId == slot0._matchGuideId then
					table.insert(slot0._pagesCo, slot7)
				end
			elseif slot0._matchGuideId then
				if slot7.unlockGuideId == slot0._matchGuideId then
					table.insert(slot0._pagesCo, slot7)
				end
			elseif HelpController.instance:canShowPage(slot7) then
				table.insert(slot0._pagesCo, slot7)
			end
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
	slot0:setBtnShow()
	slot0:_onlyShowLastGuideQuitBtn()
	NavigateMgr.instance:addEscape(ViewName.HelpView, slot0.closeThis, slot0)
	FightAudioMgr.instance:obscureBgm(true)
end

function slot0._onFinishGuideStep(slot0)
	slot0:closeThis()
end

function slot0._onlyShowLastGuideQuitBtn(slot0)
	if slot0.viewParam.guideId or slot0.viewParam.auto then
		for slot4, slot5 in ipairs(slot0._helpItems) do
			slot5:showQuitBtn(slot4 == #slot0._helpItems)
		end
	end
end

function slot0.onOpenFinish(slot0)
	HelpModel.instance:setShowedHelp(slot0._helpId)
	HelpController.instance:dispatchEvent(HelpEvent.RefreshHelp)
end

function slot0.setSelectItem(slot0)
	for slot5 = 1, #slot0._pagesCo do
		slot7 = HelpSelectItem.New()

		slot7:init({
			go = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goslider, "HelpSelectItem"),
			index = slot5,
			config = slot0._pagesCo[slot5],
			pos = 55 * (slot5 - 0.5 * (#slot0._pagesCo + 1))
		})
		slot7:updateItem()
		table.insert(slot0._selectItems, slot7)
	end
end

function slot0.setHelpItem(slot0)
	for slot4 = 1, #slot0._pagesCo do
		if slot0._pagesCo[slot4].type == HelpEnum.HelpType.Normal then
			slot7 = HelpContentItem.New()

			slot7:init({
				go = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gocontent, "HelpContentItem"),
				index = slot4,
				config = slot0._pagesCo[slot4],
				pos = slot0._space * (slot4 - 1)
			})
			slot7:updateItem()
			table.insert(slot0._helpItems, slot7)
		elseif slot0._pagesCo[slot4].type == HelpEnum.HelpType.VersionActivity then
			slot7 = HelpVersionActivityContentItem.New()

			slot7:init({
				go = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[3], slot0._gocontent, "HelpVAContentItem"),
				index = slot4,
				config = slot0._pagesCo[slot4],
				pos = slot0._space * (slot4 - 1)
			})
			slot7:updateItem()
			table.insert(slot0._helpItems, slot7)
		end
	end
end

function slot0.setBtnItem(slot0)
	gohelper.setActive(slot0._btnright.gameObject, HelpModel.instance:getTargetPageIndex() < #slot0._pagesCo)
	gohelper.setActive(slot0._btnleft.gameObject, slot1 > 1)
end

function slot0.setBtnShow(slot0)
	if slot0._pagesCo[HelpModel.instance:getTargetPageIndex()] and not string.nilorempty(slot2.icon) then
		slot0.viewContainer:setBtnShow(false)
	else
		slot0.viewContainer:setBtnShow(true)
	end
end

function slot0.selectHelpItem(slot0)
	for slot4, slot5 in pairs(slot0._selectItems) do
		slot5:updateItem()
	end

	ZProj.TweenHelper.DOAnchorPosX(slot0._gocontent.transform, (1 - HelpModel.instance:getTargetPageIndex()) * slot0._space, 0.25)
	slot0:setBtnItem()
	slot0:setBtnShow()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(GuideController.instance, GuideEvent.FinishStep, slot0._onFinishGuideStep, slot0)
	FightAudioMgr.instance:obscureBgm(false)
end

function slot0.onDestroyView(slot0)
	if slot0._selectItems then
		for slot4, slot5 in pairs(slot0._selectItems) do
			slot5:destroy()
		end

		slot0._selectItems = nil
	end

	if slot0._helpItems then
		for slot4, slot5 in pairs(slot0._helpItems) do
			slot5:destroy()
		end

		slot0._helpItems = nil
	end

	slot0._scroll:RemoveDragBeginListener()
	slot0._scroll:RemoveDragEndListener()
	slot0._viewClick:RemoveClickListener()
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

return slot0
