module("modules.logic.tower.view.permanenttower.TowerMopUpView", package.seeall)

local var_0_0 = class("TowerMopUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseFullView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeFullView")
	arg_1_0._gomopupTip = gohelper.findChild(arg_1_0.viewGO, "#go_mopupTip")
	arg_1_0._txttipDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_mopupTip/#txt_tipDesc")
	arg_1_0._btncloseMopupTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_mopupTip/#btn_closeMopupTip")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtcurPassLayer = gohelper.findChildText(arg_1_0.viewGO, "progress/#txt_curPassLayer")
	arg_1_0._txtcurAltitude = gohelper.findChildText(arg_1_0.viewGO, "progress/#txt_curPassLayer/#txt_curAltitude")
	arg_1_0._txtrewardtip = gohelper.findChildText(arg_1_0.viewGO, "rewardtip/#txt_rewardtip")
	arg_1_0._imageprogressBar = gohelper.findChildImage(arg_1_0.viewGO, "progressbar/#image_progressBar")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "progressbar/#image_progress")
	arg_1_0._goprogressContent = gohelper.findChild(arg_1_0.viewGO, "progressbar/#go_progressContent")
	arg_1_0._goprogressItem = gohelper.findChild(arg_1_0.viewGO, "progressbar/#go_progressContent/#go_progressItem")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "rewardpreview/#go_rewardContent")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "rewardpreview/#go_rewardContent/#go_rewardItem")
	arg_1_0._txtmopupNum = gohelper.findChildText(arg_1_0.viewGO, "mopuptip/#txt_mopupNum")
	arg_1_0._imageticket = gohelper.findChildImage(arg_1_0.viewGO, "mopuptip/#txt_mopupNum/#image_ticket")
	arg_1_0._btnmopupTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mopuptip/#btn_mopupTip")
	arg_1_0._btnmulti = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_multi")
	arg_1_0._txtcurMulti = gohelper.findChildText(arg_1_0.viewGO, "#btn_multi/#txt_curMulti")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#btn_multi/#go_arrow")
	arg_1_0._gomultiscroll = gohelper.findChild(arg_1_0.viewGO, "#go_multiscroll")
	arg_1_0._gomultiContent = gohelper.findChild(arg_1_0.viewGO, "#go_multiscroll/Viewport/#go_multiContent")
	arg_1_0._gomultitem = gohelper.findChild(arg_1_0.viewGO, "#go_multiscroll/Viewport/#go_multiContent/#go_multitem")
	arg_1_0._btnmopup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_mopup")
	arg_1_0._imagemopupBg = gohelper.findChildImage(arg_1_0.viewGO, "#btn_mopup/#image_mopupBg")
	arg_1_0._txtmopup = gohelper.findChildText(arg_1_0.viewGO, "#btn_mopup/#txt_mopup")
	arg_1_0._txtmopupCount = gohelper.findChildText(arg_1_0.viewGO, "#btn_mopup/#txt_mopupCount")
	arg_1_0._imagecost = gohelper.findChildImage(arg_1_0.viewGO, "#btn_mopup/#image_cost")
	arg_1_0._btncloseMultiScroll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeMultiScroll")
	arg_1_0._gomultiSelectEffect = gohelper.findChild(arg_1_0.viewGO, "rewardpreview/vx_eff")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseMopupTip:AddClickListener(arg_2_0._btncloseMopupTipOnClick, arg_2_0)
	arg_2_0._btncloseFullView:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnmopupTip:AddClickListener(arg_2_0._btnmopupTipOnClick, arg_2_0)
	arg_2_0._btnmulti:AddClickListener(arg_2_0._btnmultiOnClick, arg_2_0)
	arg_2_0._btnmopup:AddClickListener(arg_2_0._btnmopupOnClick, arg_2_0)
	arg_2_0._btncloseMultiScroll:AddClickListener(arg_2_0._btnmultiOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_2_0.checkReddotShow, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerMopUp, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseMopupTip:RemoveClickListener()
	arg_3_0._btncloseFullView:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnmopupTip:RemoveClickListener()
	arg_3_0._btnmulti:RemoveClickListener()
	arg_3_0._btnmopup:RemoveClickListener()
	arg_3_0._btncloseMultiScroll:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerMopUp, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.checkReddotShow, arg_3_0)
end

var_0_0.progressItemWidth = 157
var_0_0.multiItemHeight = 92

function var_0_0._btncloseMopupTipOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gomopupTip, false)
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnmopupTipOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._gomopupTip, true)
end

function var_0_0._btnmultiOnClick(arg_7_0)
	arg_7_0.isMultiExpand = not arg_7_0.isMultiExpand

	arg_7_0:refreshMultiScroll()
end

function var_0_0.onMultiItemClick(arg_8_0, arg_8_1)
	arg_8_0.curSelectMulti = arg_8_1

	gohelper.setActive(arg_8_0._gomultiSelectEffect, false)
	gohelper.setActive(arg_8_0._gomultiSelectEffect, true)
	arg_8_0:refreshMultiUI()
	arg_8_0:refreshRewarwd()
	arg_8_0:_btnmultiOnClick()
end

function var_0_0._btnmopupOnClick(arg_9_0)
	if TowerModel.instance:getMopUpTimes() - arg_9_0.curSelectMulti < 0 then
		GameFacade.showToast(ToastEnum.TowerMopUpNotEnoughTimes)
	else
		TowerRpc.instance:sendTowerMopUpRequest(arg_9_0.curSelectMulti)
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.multiItemTab = arg_10_0:getUserDataTb_()

	gohelper.setActive(arg_10_0._gomultitem, false)
	gohelper.setActive(arg_10_0._gomopupTip, false)
	gohelper.setActive(arg_10_0._gomultiSelectEffect, false)

	arg_10_0.curSelectMulti = 1
	arg_10_0.isMultiExpand = false
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_ripple_entry)
	arg_12_0:createMopUpMultiItem()
	arg_12_0:refreshUI()
	arg_12_0:checkReddotShow()
end

function var_0_0.createMopUpMultiItem(arg_13_0)
	for iter_13_0 = 1, 4 do
		local var_13_0 = {
			go = gohelper.clone(arg_13_0._gomultitem, arg_13_0._gomultiContent, "multi" .. iter_13_0)
		}

		var_13_0.select = gohelper.findChild(var_13_0.go, "selecticon")
		var_13_0.num = gohelper.findChildText(var_13_0.go, "num")
		var_13_0.line = gohelper.findChild(var_13_0.go, "line")
		var_13_0.posY = (iter_13_0 - 1) * var_0_0.multiItemHeight
		var_13_0.click = gohelper.getClick(var_13_0.go)

		var_13_0.click:AddClickListener(arg_13_0.onMultiItemClick, arg_13_0, iter_13_0)
		gohelper.setActive(var_13_0.go, true)

		var_13_0.num.text = luaLang("multiple") .. iter_13_0

		recthelper.setAnchorY(var_13_0.go.transform, var_13_0.posY)
		gohelper.setActive(var_13_0.line, iter_13_0 ~= 4)
		table.insert(arg_13_0.multiItemTab, var_13_0)
	end
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0.curPassLayer = TowerPermanentModel.instance.curPassLayer
	arg_14_0._txtcurPassLayer.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_layer"), {
		arg_14_0.curPassLayer
	})
	arg_14_0._txtcurAltitude.text = string.format("%sM", arg_14_0.curPassLayer * 10)
	arg_14_0.curMaxMopUpConfig = TowerConfig.instance:getMaxMopUpConfigByLayerId(arg_14_0.curPassLayer)

	if not arg_14_0.curMaxMopUpConfig then
		logError("未达到扫荡层，不应该打开扫荡界面")

		return
	end

	arg_14_0:refreshMopUpTimes()
	arg_14_0:refreshProgress()
	arg_14_0:refreshRewarwd()
	arg_14_0:refreshMultiUI()
end

function var_0_0.refreshMopUpTimes(arg_15_0)
	local var_15_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpRecoverTime)
	local var_15_1 = TowerModel.instance:getMopUpTimes()
	local var_15_2 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	arg_15_0._txttipDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_tipdesc"), {
		var_15_0,
		var_15_2,
		var_15_1
	})
	arg_15_0._txtmopupNum.text = string.format("%s/%s", var_15_1, var_15_2)

	local var_15_3 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_15_0._imageticket, var_15_3 .. "_1", true)
end

function var_0_0.refreshProgress(arg_16_0)
	local var_16_0 = TowerConfig.instance:getTowerMopUpCoList()
	local var_16_1 = arg_16_0.curMaxMopUpConfig.id
	local var_16_2 = Mathf.Min(var_16_1 + 1, #var_16_0)
	local var_16_3 = var_16_2 == var_16_1
	local var_16_4 = TowerConfig.instance:getTowerMopUpCo(var_16_2)

	if var_16_3 then
		arg_16_0._txtrewardtip.text = luaLang("mopup_rewardtip_max")
	else
		arg_16_0._txtrewardtip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_rewardtip"), {
			var_16_4.layerNum
		})
	end

	gohelper.CreateObjList(arg_16_0, arg_16_0.progressItemShow, var_16_0, arg_16_0._goprogressContent, arg_16_0._goprogressItem)

	local var_16_5 = (#var_16_0 - 1) * var_0_0.progressItemWidth

	recthelper.setWidth(arg_16_0._imageprogressBar.transform, var_16_5)

	local var_16_6 = 0

	if not var_16_3 then
		var_16_6 = (var_16_1 - 1) * var_0_0.progressItemWidth + (arg_16_0.curPassLayer - arg_16_0.curMaxMopUpConfig.layerNum) / (var_16_4.layerNum - arg_16_0.curMaxMopUpConfig.layerNum) * var_0_0.progressItemWidth
	else
		var_16_6 = var_16_5
	end

	recthelper.setWidth(arg_16_0._imageprogress.transform, var_16_6)
end

function var_0_0.progressItemShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = gohelper.findChild(arg_17_1, "go_normal")
	local var_17_1 = gohelper.findChild(arg_17_1, "go_get")
	local var_17_2 = gohelper.findChildText(arg_17_1, "txt_num")
	local var_17_3 = arg_17_2.layerNum

	gohelper.setActive(var_17_0, var_17_3 > arg_17_0.curPassLayer)
	gohelper.setActive(var_17_1, var_17_3 <= arg_17_0.curPassLayer)

	var_17_2.text = arg_17_2.layerNum
end

function var_0_0.refreshRewarwd(arg_18_0)
	local var_18_0 = GameUtil.splitString2(arg_18_0.curMaxMopUpConfig.reward, true)

	gohelper.CreateObjList(arg_18_0, arg_18_0.rewardItemShow, var_18_0, arg_18_0._gorewardContent, arg_18_0._gorewardItem)
end

function var_0_0.rewardItemShow(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = gohelper.findChild(arg_19_1, "go_itempos")
	local var_19_1 = IconMgr.instance:getCommonPropItemIcon(var_19_0)
	local var_19_2 = arg_19_2[3] * arg_19_0.curSelectMulti

	var_19_1:setMOValue(arg_19_2[1], arg_19_2[2], var_19_2)
	var_19_1:setHideLvAndBreakFlag(true)
	var_19_1:hideEquipLvAndBreak(true)
	var_19_1:setCountFontSize(51)
end

function var_0_0.refreshMultiUI(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.multiItemTab) do
		gohelper.setActive(iter_20_1.select, iter_20_0 == arg_20_0.curSelectMulti)
	end

	local var_20_0 = TowerModel.instance:getMopUpTimes()

	arg_20_0._txtmopup.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_times"), {
		GameUtil.getNum2Chinese(arg_20_0.curSelectMulti)
	})
	arg_20_0._txtmopupCount.text = string.format("-%s", arg_20_0.curSelectMulti)

	SLFramework.UGUI.GuiHelper.SetColor(arg_20_0._txtmopupCount, var_20_0 - arg_20_0.curSelectMulti < 0 and "#800015" or "#070706")

	arg_20_0._txtcurMulti.text = luaLang("multiple") .. arg_20_0.curSelectMulti

	arg_20_0:refreshMultiScroll()
end

function var_0_0.refreshMultiScroll(arg_21_0)
	transformhelper.setLocalScale(arg_21_0._goarrow.transform, 1, arg_21_0.isMultiExpand and -1 or 1, 1)
	gohelper.setActive(arg_21_0._gomultiscroll, arg_21_0.isMultiExpand)
	gohelper.setActive(arg_21_0._btncloseMultiScroll.gameObject, arg_21_0.isMultiExpand)
end

function var_0_0.checkReddotShow(arg_22_0)
	local var_22_0 = TowerModel.instance:getMopUpTimes()
	local var_22_1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	if var_22_0 == tonumber(var_22_1) then
		TimeUtil.setDayFirstLoginRed(TowerEnum.LocalPrefsKey.MopUpDailyRefresh)
	end
end

function var_0_0.onClose(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.multiItemTab) do
		iter_23_1.click:RemoveClickListener()
	end

	TowerController.instance:checkMopUpReddotShow()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
