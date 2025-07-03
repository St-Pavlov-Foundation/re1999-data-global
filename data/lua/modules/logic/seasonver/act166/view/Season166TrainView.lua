module("modules.logic.seasonver.act166.view.Season166TrainView", package.seeall)

local var_0_0 = class("Season166TrainView", BaseView)

function var_0_0._rewardItemShow(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0._itemList[arg_1_2]
	local var_1_1 = var_1_0.itemIcon
	local var_1_2 = var_1_0.viewGO
	local var_1_3 = var_1_0.goHasGet
	local var_1_4 = string.splitToNumber(arg_1_1, "#")
	local var_1_5 = Season166TrainModel.instance:checkIsFinish(arg_1_0.actId, arg_1_0.trainId)

	gohelper.setActive(var_1_2, true)
	var_1_1:setMOValue(var_1_4[1], var_1_4[2], var_1_4[3])
	var_1_1:setHideLvAndBreakFlag(true)
	var_1_1:hideEquipLvAndBreak(true)
	var_1_1:setCountFontSize(51)
	gohelper.setActive(var_1_3, var_1_5)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_bg")
	arg_2_0._txtcurIndex = gohelper.findChildText(arg_2_0.viewGO, "right/title/#txt_curIndex")
	arg_2_0._txttotalIndex = gohelper.findChildText(arg_2_0.viewGO, "right/title/#txt_totalIndex")
	arg_2_0._txttitle = gohelper.findChildText(arg_2_0.viewGO, "right/title/#txt_title")
	arg_2_0._txttitleEn = gohelper.findChildText(arg_2_0.viewGO, "right/title/#txt_titleen")
	arg_2_0._btnleftArrow = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "right/title/#btn_leftArrow")
	arg_2_0._btnrightArrow = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "right/title/#btn_rightArrow")
	arg_2_0._txtenemyinfo = gohelper.findChildText(arg_2_0.viewGO, "right/episodeInfo/enemyInfo/#txt_enemyinfo")
	arg_2_0._txtepisodeInfo = gohelper.findChildText(arg_2_0.viewGO, "right/episodeInfo/#txt_episodeInfo")
	arg_2_0._gorewardContent = gohelper.findChild(arg_2_0.viewGO, "right/reward/#go_rewardContent")
	arg_2_0._gorewardItem = gohelper.findChild(arg_2_0.viewGO, "right/reward/#go_rewardContent/#go_rewardItem")
	arg_2_0._btnfight = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "right/#btn_fight")
	arg_2_0._gotopleft = gohelper.findChild(arg_2_0.viewGO, "#go_topleft")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnleftArrow:AddClickListener(arg_3_0._btnleftArrowOnClick, arg_3_0)
	arg_3_0._btnrightArrow:AddClickListener(arg_3_0._btnrightArrowOnClick, arg_3_0)
	arg_3_0._btnfight:AddClickListener(arg_3_0._btnfightOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnleftArrow:RemoveClickListener()
	arg_4_0._btnrightArrow:RemoveClickListener()
	arg_4_0._btnfight:RemoveClickListener()
end

function var_0_0._btnleftArrowOnClick(arg_5_0)
	arg_5_0.trainId = Mathf.Max(arg_5_0.trainId - 1, 1)

	arg_5_0:refreshUI()
end

function var_0_0._btnrightArrowOnClick(arg_6_0)
	local var_6_0 = Mathf.Min(arg_6_0.trainId + 1, #arg_6_0.trainConfigList)

	if not arg_6_0.unlockTrainMap[var_6_0] then
		GameFacade.showToast(ToastEnum.Season166TrainLock)

		return
	end

	arg_6_0.trainId = var_6_0

	arg_6_0:refreshUI()
end

function var_0_0._btnfightOnClick(arg_7_0)
	Season166TrainController.instance:enterTrainFightScene()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._itemList = {}

	gohelper.setActive(arg_8_0._gorewardItem, false)

	arg_8_0.rightArrowCanvasGroup = arg_8_0._btnrightArrow.gameObject:GetComponent(gohelper.Type_CanvasGroup)
	arg_8_0._animPlayer = SLFramework.AnimatorPlayer.Get(arg_8_0.viewGO)
	arg_8_0.isClickClose = false
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.actId = arg_10_0.viewParam.actId
	arg_10_0.trainId = arg_10_0.viewParam.trainId
	arg_10_0.config = arg_10_0.viewParam.config
	arg_10_0.trainConfigList = Season166Config.instance:getSeasonTrainCos(arg_10_0.actId)
	arg_10_0.unlockTrainMap = Season166TrainModel.instance:getUnlockTrainInfoMap(arg_10_0.actId)

	Season166Controller.instance:dispatchEvent(Season166Event.OpenTrainView, {
		isEnter = true
	})
	arg_10_0:refreshUI()
	arg_10_0.viewContainer:setOverrideCloseClick(arg_10_0.setCloseOverrideFunc, arg_10_0)
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0:refreshInfo()
	arg_11_0:refreshReward()
	Season166Controller.instance:dispatchEvent(Season166Event.TrainViewChangeTrain, arg_11_0.trainId)
end

function var_0_0.refreshInfo(arg_12_0)
	arg_12_0.config = arg_12_0.trainConfigList[arg_12_0.trainId]
	arg_12_0._txtcurIndex.text = string.format("%02d", arg_12_0.trainId)
	arg_12_0._txttotalIndex.text = string.format("%02d", #arg_12_0.trainConfigList)
	arg_12_0._txttitle.text = arg_12_0.config.name
	arg_12_0._txttitleEn.text = arg_12_0.config.nameEn
	arg_12_0._txtepisodeInfo.text = arg_12_0.config.desc
	arg_12_0._txtenemyinfo.text = HeroConfig.instance:getLevelDisplayVariant(arg_12_0.config.level)

	Season166TrainModel.instance:initTrainData(arg_12_0.actId, arg_12_0.trainId)
	gohelper.setActive(arg_12_0._btnleftArrow.gameObject, arg_12_0.trainId > 1)
	gohelper.setActive(arg_12_0._btnrightArrow.gameObject, arg_12_0.trainId < #arg_12_0.trainConfigList)

	local var_12_0 = Mathf.Min(arg_12_0.trainId + 1, #arg_12_0.trainConfigList)

	arg_12_0.rightArrowCanvasGroup.alpha = arg_12_0.unlockTrainMap[var_12_0] and 1 or 0.5
end

function var_0_0.refreshReward(arg_13_0)
	local var_13_0 = string.split(arg_13_0.config.firstBonus, "|") or {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if not arg_13_0._itemList[iter_13_0] then
			local var_13_1 = gohelper.cloneInPlace(arg_13_0._gorewardItem)
			local var_13_2, var_13_3 = arg_13_0:rewardItemShow(var_13_1, iter_13_1, iter_13_0)
			local var_13_4 = {
				viewGO = var_13_1,
				itemIcon = var_13_2,
				goHasGet = var_13_3
			}

			arg_13_0._itemList[iter_13_0] = var_13_4
		end

		arg_13_0:_rewardItemShow(iter_13_1, iter_13_0)
	end

	for iter_13_2 = #var_13_0 + 1, #arg_13_0._itemList do
		local var_13_5 = arg_13_0._itemList[iter_13_2]

		if var_13_5 then
			gohelper.setActive(var_13_5.viewGO, false)
		end
	end
end

function var_0_0.rewardItemShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = gohelper.findChild(arg_14_1, "go_itempos")
	local var_14_1 = gohelper.findChild(arg_14_1, "go_hasget")
	local var_14_2 = IconMgr.instance:getCommonPropItemIcon(var_14_0)
	local var_14_3 = string.splitToNumber(arg_14_2, "#")

	var_14_2:setMOValue(var_14_3[1], var_14_3[2], var_14_3[3])
	var_14_2:setHideLvAndBreakFlag(true)
	var_14_2:hideEquipLvAndBreak(true)
	var_14_2:setCountFontSize(51)

	local var_14_4 = Season166TrainModel.instance:checkIsFinish(arg_14_0.actId, arg_14_0.trainId)

	gohelper.setActive(var_14_1, var_14_4)

	return var_14_2, var_14_1
end

function var_0_0.setCloseOverrideFunc(arg_15_0)
	if not arg_15_0.isClickClose then
		arg_15_0._animPlayer:Play("out", arg_15_0.closeThis, arg_15_0)
		Season166Controller.instance:dispatchEvent(Season166Event.CloseTrainView, {
			isEnter = false
		})
		Season166Controller.instance:dispatchEvent(Season166Event.TrainViewChangeTrain)

		arg_15_0.isClickClose = true
	end
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
