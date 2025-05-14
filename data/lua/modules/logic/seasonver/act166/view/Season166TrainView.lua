module("modules.logic.seasonver.act166.view.Season166TrainView", package.seeall)

local var_0_0 = class("Season166TrainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtcurIndex = gohelper.findChildText(arg_1_0.viewGO, "right/title/#txt_curIndex")
	arg_1_0._txttotalIndex = gohelper.findChildText(arg_1_0.viewGO, "right/title/#txt_totalIndex")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "right/title/#txt_title")
	arg_1_0._txttitleEn = gohelper.findChildText(arg_1_0.viewGO, "right/title/#txt_titleen")
	arg_1_0._btnleftArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/title/#btn_leftArrow")
	arg_1_0._btnrightArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/title/#btn_rightArrow")
	arg_1_0._txtenemyinfo = gohelper.findChildText(arg_1_0.viewGO, "right/episodeInfo/enemyInfo/#txt_enemyinfo")
	arg_1_0._txtepisodeInfo = gohelper.findChildText(arg_1_0.viewGO, "right/episodeInfo/#txt_episodeInfo")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "right/reward/#go_rewardContent")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "right/reward/#go_rewardContent/#go_rewardItem")
	arg_1_0._btnfight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_fight")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnleftArrow:AddClickListener(arg_2_0._btnleftArrowOnClick, arg_2_0)
	arg_2_0._btnrightArrow:AddClickListener(arg_2_0._btnrightArrowOnClick, arg_2_0)
	arg_2_0._btnfight:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnleftArrow:RemoveClickListener()
	arg_3_0._btnrightArrow:RemoveClickListener()
	arg_3_0._btnfight:RemoveClickListener()
end

function var_0_0._btnleftArrowOnClick(arg_4_0)
	arg_4_0.trainId = Mathf.Max(arg_4_0.trainId - 1, 1)

	arg_4_0:refreshUI()
end

function var_0_0._btnrightArrowOnClick(arg_5_0)
	local var_5_0 = Mathf.Min(arg_5_0.trainId + 1, #arg_5_0.trainConfigList)

	if not arg_5_0.unlockTrainMap[var_5_0] then
		GameFacade.showToast(ToastEnum.Season166TrainLock)

		return
	end

	arg_5_0.trainId = var_5_0

	arg_5_0:refreshUI()
end

function var_0_0._btnfightOnClick(arg_6_0)
	Season166TrainController.instance:enterTrainFightScene()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.rightArrowCanvasGroup = arg_7_0._btnrightArrow.gameObject:GetComponent(gohelper.Type_CanvasGroup)
	arg_7_0._animPlayer = SLFramework.AnimatorPlayer.Get(arg_7_0.viewGO)
	arg_7_0.isClickClose = false
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.actId = arg_9_0.viewParam.actId
	arg_9_0.trainId = arg_9_0.viewParam.trainId
	arg_9_0.config = arg_9_0.viewParam.config
	arg_9_0.trainConfigList = Season166Config.instance:getSeasonTrainCos(arg_9_0.actId)
	arg_9_0.unlockTrainMap = Season166TrainModel.instance:getUnlockTrainInfoMap(arg_9_0.actId)

	Season166Controller.instance:dispatchEvent(Season166Event.OpenTrainView, {
		isEnter = true
	})
	arg_9_0:refreshUI()
	arg_9_0.viewContainer:setOverrideCloseClick(arg_9_0.setCloseOverrideFunc, arg_9_0)
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0:refreshInfo()
	arg_10_0:refreshReward()
	Season166Controller.instance:dispatchEvent(Season166Event.TrainViewChangeTrain, arg_10_0.trainId)
end

function var_0_0.refreshInfo(arg_11_0)
	arg_11_0.config = arg_11_0.trainConfigList[arg_11_0.trainId]
	arg_11_0._txtcurIndex.text = string.format("%02d", arg_11_0.trainId)
	arg_11_0._txttotalIndex.text = string.format("%02d", #arg_11_0.trainConfigList)
	arg_11_0._txttitle.text = arg_11_0.config.name
	arg_11_0._txttitleEn.text = arg_11_0.config.nameEn
	arg_11_0._txtepisodeInfo.text = arg_11_0.config.desc
	arg_11_0._txtenemyinfo.text = HeroConfig.instance:getLevelDisplayVariant(arg_11_0.config.level)

	Season166TrainModel.instance:initTrainData(arg_11_0.actId, arg_11_0.trainId)
	gohelper.setActive(arg_11_0._btnleftArrow.gameObject, arg_11_0.trainId > 1)
	gohelper.setActive(arg_11_0._btnrightArrow.gameObject, arg_11_0.trainId < #arg_11_0.trainConfigList)

	local var_11_0 = Mathf.Min(arg_11_0.trainId + 1, #arg_11_0.trainConfigList)

	arg_11_0.rightArrowCanvasGroup.alpha = arg_11_0.unlockTrainMap[var_11_0] and 1 or 0.5
end

function var_0_0.refreshReward(arg_12_0)
	local var_12_0 = string.split(arg_12_0.config.firstBonus, "|")

	gohelper.CreateObjList(arg_12_0, arg_12_0.rewardItemShow, var_12_0, arg_12_0._gorewardContent, arg_12_0._gorewardItem)
end

function var_0_0.rewardItemShow(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = gohelper.findChild(arg_13_1, "go_itempos")
	local var_13_1 = gohelper.findChild(arg_13_1, "go_hasget")
	local var_13_2 = IconMgr.instance:getCommonPropItemIcon(var_13_0)
	local var_13_3 = string.splitToNumber(arg_13_2, "#")

	var_13_2:setMOValue(var_13_3[1], var_13_3[2], var_13_3[3])
	var_13_2:setHideLvAndBreakFlag(true)
	var_13_2:hideEquipLvAndBreak(true)
	var_13_2:setCountFontSize(51)

	local var_13_4 = Season166TrainModel.instance:checkIsFinish(arg_13_0.actId, arg_13_0.trainId)

	gohelper.setActive(var_13_1, var_13_4)
end

function var_0_0.setCloseOverrideFunc(arg_14_0)
	if not arg_14_0.isClickClose then
		arg_14_0._animPlayer:Play("out", arg_14_0.closeThis, arg_14_0)
		Season166Controller.instance:dispatchEvent(Season166Event.CloseTrainView, {
			isEnter = false
		})
		Season166Controller.instance:dispatchEvent(Season166Event.TrainViewChangeTrain)

		arg_14_0.isClickClose = true
	end
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
