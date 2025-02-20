module("modules.logic.tower.view.permanenttower.TowerMopUpView", package.seeall)

slot0 = class("TowerMopUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._btncloseFullView = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeFullView")
	slot0._gomopupTip = gohelper.findChild(slot0.viewGO, "#go_mopupTip")
	slot0._txttipDesc = gohelper.findChildText(slot0.viewGO, "#go_mopupTip/#txt_tipDesc")
	slot0._btncloseMopupTip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_mopupTip/#btn_closeMopupTip")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtcurPassLayer = gohelper.findChildText(slot0.viewGO, "progress/#txt_curPassLayer")
	slot0._txtcurAltitude = gohelper.findChildText(slot0.viewGO, "progress/#txt_curPassLayer/#txt_curAltitude")
	slot0._txtrewardtip = gohelper.findChildText(slot0.viewGO, "rewardtip/#txt_rewardtip")
	slot0._imageprogressBar = gohelper.findChildImage(slot0.viewGO, "progressbar/#image_progressBar")
	slot0._imageprogress = gohelper.findChildImage(slot0.viewGO, "progressbar/#image_progress")
	slot0._goprogressContent = gohelper.findChild(slot0.viewGO, "progressbar/#go_progressContent")
	slot0._goprogressItem = gohelper.findChild(slot0.viewGO, "progressbar/#go_progressContent/#go_progressItem")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "rewardpreview/#go_rewardContent")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "rewardpreview/#go_rewardContent/#go_rewardItem")
	slot0._txtmopupNum = gohelper.findChildText(slot0.viewGO, "mopuptip/#txt_mopupNum")
	slot0._imageticket = gohelper.findChildImage(slot0.viewGO, "mopuptip/#txt_mopupNum/#image_ticket")
	slot0._btnmopupTip = gohelper.findChildButtonWithAudio(slot0.viewGO, "mopuptip/#btn_mopupTip")
	slot0._btnmulti = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_multi")
	slot0._txtcurMulti = gohelper.findChildText(slot0.viewGO, "#btn_multi/#txt_curMulti")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#btn_multi/#go_arrow")
	slot0._gomultiscroll = gohelper.findChild(slot0.viewGO, "#go_multiscroll")
	slot0._gomultiContent = gohelper.findChild(slot0.viewGO, "#go_multiscroll/Viewport/#go_multiContent")
	slot0._gomultitem = gohelper.findChild(slot0.viewGO, "#go_multiscroll/Viewport/#go_multiContent/#go_multitem")
	slot0._btnmopup = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_mopup")
	slot0._imagemopupBg = gohelper.findChildImage(slot0.viewGO, "#btn_mopup/#image_mopupBg")
	slot0._txtmopup = gohelper.findChildText(slot0.viewGO, "#btn_mopup/#txt_mopup")
	slot0._txtmopupCount = gohelper.findChildText(slot0.viewGO, "#btn_mopup/#txt_mopupCount")
	slot0._imagecost = gohelper.findChildImage(slot0.viewGO, "#btn_mopup/#image_cost")
	slot0._btncloseMultiScroll = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeMultiScroll")
	slot0._gomultiSelectEffect = gohelper.findChild(slot0.viewGO, "rewardpreview/vx_eff")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseMopupTip:AddClickListener(slot0._btncloseMopupTipOnClick, slot0)
	slot0._btncloseFullView:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnmopupTip:AddClickListener(slot0._btnmopupTipOnClick, slot0)
	slot0._btnmulti:AddClickListener(slot0._btnmultiOnClick, slot0)
	slot0._btnmopup:AddClickListener(slot0._btnmopupOnClick, slot0)
	slot0._btncloseMultiScroll:AddClickListener(slot0._btnmultiOnClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.refreshUI, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.checkReddotShow, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerMopUp, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseMopupTip:RemoveClickListener()
	slot0._btncloseFullView:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnmopupTip:RemoveClickListener()
	slot0._btnmulti:RemoveClickListener()
	slot0._btnmopup:RemoveClickListener()
	slot0._btncloseMultiScroll:RemoveClickListener()
	slot0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.refreshUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerMopUp, slot0.refreshUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.checkReddotShow, slot0)
end

slot0.progressItemWidth = 157
slot0.multiItemHeight = 92

function slot0._btncloseMopupTipOnClick(slot0)
	gohelper.setActive(slot0._gomopupTip, false)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnmopupTipOnClick(slot0)
	gohelper.setActive(slot0._gomopupTip, true)
end

function slot0._btnmultiOnClick(slot0)
	slot0.isMultiExpand = not slot0.isMultiExpand

	slot0:refreshMultiScroll()
end

function slot0.onMultiItemClick(slot0, slot1)
	slot0.curSelectMulti = slot1

	gohelper.setActive(slot0._gomultiSelectEffect, false)
	gohelper.setActive(slot0._gomultiSelectEffect, true)
	slot0:refreshMultiUI()
	slot0:refreshRewarwd()
	slot0:_btnmultiOnClick()
end

function slot0._btnmopupOnClick(slot0)
	if TowerModel.instance:getMopUpTimes() - slot0.curSelectMulti < 0 then
		GameFacade.showToast(ToastEnum.TowerMopUpNotEnoughTimes)
	else
		TowerRpc.instance:sendTowerMopUpRequest(slot0.curSelectMulti)
	end
end

function slot0._editableInitView(slot0)
	slot0.multiItemTab = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gomultitem, false)
	gohelper.setActive(slot0._gomopupTip, false)
	gohelper.setActive(slot0._gomultiSelectEffect, false)

	slot0.curSelectMulti = 1
	slot0.isMultiExpand = false
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_ripple_entry)
	slot0:createMopUpMultiItem()
	slot0:refreshUI()
	slot0:checkReddotShow()
end

function slot0.createMopUpMultiItem(slot0)
	for slot4 = 1, 4 do
		slot5 = {
			go = gohelper.clone(slot0._gomultitem, slot0._gomultiContent, "multi" .. slot4)
		}
		slot5.select = gohelper.findChild(slot5.go, "selecticon")
		slot5.num = gohelper.findChildText(slot5.go, "num")
		slot5.line = gohelper.findChild(slot5.go, "line")
		slot5.posY = (slot4 - 1) * uv0.multiItemHeight
		slot5.click = gohelper.getClick(slot5.go)

		slot5.click:AddClickListener(slot0.onMultiItemClick, slot0, slot4)
		gohelper.setActive(slot5.go, true)

		slot5.num.text = luaLang("multiple") .. slot4

		recthelper.setAnchorY(slot5.go.transform, slot5.posY)
		gohelper.setActive(slot5.line, slot4 ~= 4)
		table.insert(slot0.multiItemTab, slot5)
	end
end

function slot0.refreshUI(slot0)
	slot0.curPassLayer = TowerPermanentModel.instance.curPassLayer
	slot0._txtcurPassLayer.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_layer"), {
		slot0.curPassLayer
	})
	slot0._txtcurAltitude.text = string.format("%sM", slot0.curPassLayer * 10)
	slot0.curMaxMopUpConfig = TowerConfig.instance:getMaxMopUpConfigByLayerId(slot0.curPassLayer)

	if not slot0.curMaxMopUpConfig then
		logError("未达到扫荡层，不应该打开扫荡界面")

		return
	end

	slot0:refreshMopUpTimes()
	slot0:refreshProgress()
	slot0:refreshRewarwd()
	slot0:refreshMultiUI()
end

function slot0.refreshMopUpTimes(slot0)
	slot2 = TowerModel.instance:getMopUpTimes()
	slot3 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)
	slot0._txttipDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_tipdesc"), {
		TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpRecoverTime),
		slot3,
		slot2
	})
	slot0._txtmopupNum.text = string.format("%s/%s", slot2, slot3)

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageticket, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon) .. "_1", true)
end

function slot0.refreshProgress(slot0)
	slot2 = slot0.curMaxMopUpConfig.id
	slot5 = TowerConfig.instance:getTowerMopUpCo(slot3)

	if Mathf.Min(slot2 + 1, #TowerConfig.instance:getTowerMopUpCoList()) == slot2 then
		slot0._txtrewardtip.text = luaLang("mopup_rewardtip_max")
	else
		slot0._txtrewardtip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_rewardtip"), {
			slot5.layerNum
		})
	end

	gohelper.CreateObjList(slot0, slot0.progressItemShow, slot1, slot0._goprogressContent, slot0._goprogressItem)
	recthelper.setWidth(slot0._imageprogressBar.transform, (#slot1 - 1) * uv0.progressItemWidth)

	slot7 = 0

	recthelper.setWidth(slot0._imageprogress.transform, not slot4 and (slot2 - 1) * uv0.progressItemWidth + (slot0.curPassLayer - slot0.curMaxMopUpConfig.layerNum) / (slot5.layerNum - slot0.curMaxMopUpConfig.layerNum) * uv0.progressItemWidth or slot6)
end

function slot0.progressItemShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "go_normal"), slot0.curPassLayer < slot2.layerNum)
	gohelper.setActive(gohelper.findChild(slot1, "go_get"), slot7 <= slot0.curPassLayer)

	gohelper.findChildText(slot1, "txt_num").text = slot2.layerNum
end

function slot0.refreshRewarwd(slot0)
	gohelper.CreateObjList(slot0, slot0.rewardItemShow, GameUtil.splitString2(slot0.curMaxMopUpConfig.reward, true), slot0._gorewardContent, slot0._gorewardItem)
end

function slot0.rewardItemShow(slot0, slot1, slot2, slot3)
	slot5 = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot1, "go_itempos"))

	slot5:setMOValue(slot2[1], slot2[2], slot2[3] * slot0.curSelectMulti)
	slot5:setHideLvAndBreakFlag(true)
	slot5:hideEquipLvAndBreak(true)
	slot5:setCountFontSize(51)
end

function slot0.refreshMultiUI(slot0)
	for slot4, slot5 in ipairs(slot0.multiItemTab) do
		gohelper.setActive(slot5.select, slot4 == slot0.curSelectMulti)
	end

	slot0._txtmopup.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_times"), {
		GameUtil.getNum2Chinese(slot0.curSelectMulti)
	})
	slot0._txtmopupCount.text = string.format("-%s", slot0.curSelectMulti)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtmopupCount, TowerModel.instance:getMopUpTimes() - slot0.curSelectMulti < 0 and "#800015" or "#070706")

	slot0._txtcurMulti.text = luaLang("multiple") .. slot0.curSelectMulti

	slot0:refreshMultiScroll()
end

function slot0.refreshMultiScroll(slot0)
	transformhelper.setLocalScale(slot0._goarrow.transform, 1, slot0.isMultiExpand and -1 or 1, 1)
	gohelper.setActive(slot0._gomultiscroll, slot0.isMultiExpand)
	gohelper.setActive(slot0._btncloseMultiScroll.gameObject, slot0.isMultiExpand)
end

function slot0.checkReddotShow(slot0)
	if TowerModel.instance:getMopUpTimes() == tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)) then
		TimeUtil.setDayFirstLoginRed(TowerEnum.LocalPrefsKey.MopUpDailyRefresh)
	end
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0.multiItemTab) do
		slot5.click:RemoveClickListener()
	end

	TowerController.instance:checkMopUpReddotShow()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
end

function slot0.onDestroyView(slot0)
end

return slot0
