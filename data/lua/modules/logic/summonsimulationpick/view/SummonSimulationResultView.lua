module("modules.logic.summonsimulationpick.view.SummonSimulationResultView", package.seeall)

local var_0_0 = class("SummonSimulationResultView", BaseView)

var_0_0.SAVED_ANIM_NAME = "open"
var_0_0.IDLE_ANIM_NAME = "idle"
var_0_0.FIRST_SAVE_ANIM_DELAY = 0.5
var_0_0.SUMMON_CONFIRM_TEXT = "p_summonpickresultview_txt_confirm"
var_0_0.SUMMON_AGAIN_TEXT = "p_summonpickresultview_txt_again"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagebg0 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg0")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._simageline1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_line1")
	arg_1_0._simageline2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_line2")
	arg_1_0._simageline3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_line3")
	arg_1_0._goheroitem10 = gohelper.findChild(arg_1_0.viewGO, "herocontent/#go_heroitem10")
	arg_1_0._goheroitem5 = gohelper.findChild(arg_1_0.viewGO, "herocontent/#go_heroitem5")
	arg_1_0._goheroitem2 = gohelper.findChild(arg_1_0.viewGO, "herocontent/#go_heroitem2")
	arg_1_0._goheroitem4 = gohelper.findChild(arg_1_0.viewGO, "herocontent/#go_heroitem4")
	arg_1_0._goheroitem7 = gohelper.findChild(arg_1_0.viewGO, "herocontent/#go_heroitem7")
	arg_1_0._goheroitem8 = gohelper.findChild(arg_1_0.viewGO, "herocontent/#go_heroitem8")
	arg_1_0._goheroitem3 = gohelper.findChild(arg_1_0.viewGO, "herocontent/#go_heroitem3")
	arg_1_0._goheroitem1 = gohelper.findChild(arg_1_0.viewGO, "herocontent/#go_heroitem1")
	arg_1_0._goheroitem6 = gohelper.findChild(arg_1_0.viewGO, "herocontent/#go_heroitem6")
	arg_1_0._goheroitem9 = gohelper.findChild(arg_1_0.viewGO, "herocontent/#go_heroitem9")
	arg_1_0._btnsave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Btn/#btn_save")
	arg_1_0._gosaved = gohelper.findChild(arg_1_0.viewGO, "Btn/#go_saved")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Btn/#btn_confirm")
	arg_1_0._btnagain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Btn/#btn_again")
	arg_1_0._btntips = gohelper.findChildButton(arg_1_0.viewGO, "#btn_tips")
	arg_1_0._txtresttime = gohelper.findChildText(arg_1_0.viewGO, "Btn/rest/#txt_resttime")
	arg_1_0._txtagain = gohelper.findChildText(arg_1_0.viewGO, "Btn/#btn_again/#txt_again")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsave:AddClickListener(arg_2_0._btnsaveOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnagain:AddClickListener(arg_2_0._btnagainOnClick, arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._btntipsOnClick, arg_2_0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSummonSimulation, arg_2_0.onSummonSimulation, arg_2_0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSaveResult, arg_2_0.onSummonSave, arg_2_0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSelectResult, arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsave:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnagain:RemoveClickListener()
	arg_3_0._btntips:RemoveClickListener()
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSummonSimulation, arg_3_0.onSummonSimulation, arg_3_0)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSaveResult, arg_3_0.onSummonSave, arg_3_0)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSelectResult, arg_3_0.closeThis, arg_3_0)
end

function var_0_0._btnsaveOnClick(arg_4_0)
	if arg_4_0._cantClose then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonSimulationPickView, {
		activityId = arg_4_0._activityId,
		pickType = SummonSimulationEnum.PickType.SaveResult
	})
end

function var_0_0._btnconfirmOnClick(arg_5_0)
	if arg_5_0._cantClose then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonSimulationPickView, {
		activityId = arg_5_0._activityId,
		pickType = SummonSimulationEnum.PickType.SelectResult
	})
end

function var_0_0._btnagainOnClick(arg_6_0)
	if arg_6_0._cantClose then
		return
	end

	if SummonSimulationPickModel.instance:getActInfo(arg_6_0._activityId).leftTimes > 0 then
		SummonSimulationPickController.instance:summonSimulation(arg_6_0._activityId)
	else
		ViewMgr.instance:openView(ViewName.SummonSimulationPickView, {
			activityId = arg_6_0._activityId,
			pickType = SummonSimulationEnum.PickType.SelectResult
		})
	end
end

function var_0_0._btntipsOnClick(arg_7_0)
	if arg_7_0._cantClose then
		return
	end

	SummonSimulationPickController.instance:openSummonTips(arg_7_0._activityId)
end

function var_0_0._btncloseOnClick(arg_8_0)
	if arg_8_0._cantClose then
		return
	end

	local var_8_0 = MessageBoxIdDefine.SummonSimulationExit

	GameFacade.showMessageBox(var_8_0, MsgBoxEnum.BoxType.Yes_No, arg_8_0._confirmExit, nil, nil, arg_8_0)
end

function var_0_0._confirmExit(arg_9_0)
	if arg_9_0._isReprint == false then
		local var_9_0 = SummonSimulationPickController.instance

		SummonController.instance:setSummonEndOpenCallBack(var_9_0.backHome, var_9_0)
	end

	arg_9_0.isClickBack = true

	arg_9_0:closeThis()
end

function var_0_0.onSummonSimulation(arg_10_0)
	arg_10_0.isSummon = true

	SummonSimulationPickController.instance:startBlack()
	arg_10_0:closeThis()
end

function var_0_0._editableInitView(arg_11_0)
	gohelper.setActive(arg_11_0._goheroitem, false)

	arg_11_0._heroItemTables = {}

	for iter_11_0 = 1, 10 do
		local var_11_0 = arg_11_0:getUserDataTb_()

		var_11_0.go = gohelper.findChild(arg_11_0.viewGO, "herocontent/#go_heroitem" .. iter_11_0)
		var_11_0.txtname = gohelper.findChildText(var_11_0.go, "name")
		var_11_0.txtnameen = gohelper.findChildText(var_11_0.go, "nameen")
		var_11_0.imagerare = gohelper.findChildImage(var_11_0.go, "rare")
		var_11_0.equiprare = gohelper.findChildImage(var_11_0.go, "equiprare")
		var_11_0.imagecareer = gohelper.findChildImage(var_11_0.go, "career")
		var_11_0.imageequipcareer = gohelper.findChildImage(var_11_0.go, "equipcareer")
		var_11_0.goHeroIcon = gohelper.findChild(var_11_0.go, "heroicon")
		var_11_0.simageicon = gohelper.findChildSingleImage(var_11_0.go, "heroicon/icon")
		var_11_0.simageequipicon = gohelper.findChildSingleImage(var_11_0.go, "equipicon")
		var_11_0.imageicon = gohelper.findChildImage(var_11_0.go, "heroicon/icon")
		var_11_0.goeffect = gohelper.findChild(var_11_0.go, "effect")
		var_11_0.btnself = gohelper.findChildButtonWithAudio(var_11_0.go, "btn_self")
		var_11_0.goluckybag = gohelper.findChild(var_11_0.go, "luckybag")
		var_11_0.txtluckybagname = gohelper.findChildText(var_11_0.goluckybag, "name")
		var_11_0.txtluckybagnameen = gohelper.findChildText(var_11_0.goluckybag, "nameen")
		var_11_0.simageluckgbagicon = gohelper.findChildSingleImage(var_11_0.goluckybag, "icon")

		var_11_0.btnself:AddClickListener(arg_11_0.onClickItem, {
			view = arg_11_0,
			index = iter_11_0
		})
		table.insert(arg_11_0._heroItemTables, var_11_0)
	end

	arg_11_0._cantClose = true
	arg_11_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, arg_11_0._tweenFinish, arg_11_0, nil, EaseType.Linear)
	arg_11_0._goSaveAnimator = gohelper.findChildComponent(arg_11_0._gosaved.gameObject, "", gohelper.Type_Animator)
end

function var_0_0.onDestroyView(arg_12_0)
	for iter_12_0 = 1, 10 do
		local var_12_0 = arg_12_0._heroItemTables[iter_12_0]

		if var_12_0 then
			if var_12_0.simageicon then
				var_12_0.simageicon:UnLoadImage()
			end

			if var_12_0.simageequipicon then
				var_12_0.simageequipicon:UnLoadImage()
			end

			if var_12_0.btnself then
				var_12_0.btnself:RemoveClickListener()
			end

			if var_12_0.simageluckgbagicon then
				var_12_0.simageluckgbagicon:UnLoadImage()
			end
		end
	end

	if arg_12_0._tweenId then
		ZProj.TweenHelper.KillById(arg_12_0._tweenId)
	end
end

function var_0_0.onOpen(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_TenHero_OpenAll)

	local var_13_0 = arg_13_0.viewParam.summonResultList

	arg_13_0._curPool = arg_13_0.viewParam.curPool
	arg_13_0._summonResultList = {}
	arg_13_0._isReprint = arg_13_0.viewParam.isReprint ~= nil and arg_13_0.viewParam.isReprint or false

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		table.insert(arg_13_0._summonResultList, iter_13_1)
	end

	if arg_13_0._curPool then
		SummonModel.sortResult(arg_13_0._summonResultList, arg_13_0._curPool.id)
	end

	arg_13_0.viewContainer.navigateView:setOverrideClose(arg_13_0._btncloseOnClick, arg_13_0)
	arg_13_0:_refreshUI()
	NavigateMgr.instance:addEscape(ViewName.SummonSimulationResultView, arg_13_0._btnconfirmOnClick, arg_13_0)
end

function var_0_0.onClose(arg_14_0)
	arg_14_0.viewContainer.navigateView:setOverrideClose(nil, nil)
	arg_14_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_14_0.onSummonReply, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.delayPlayBtnAnim, arg_14_0)
end

function var_0_0.onCloseFinish(arg_15_0)
	if not arg_15_0:_showCommonPropView() then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonResultClose)
	end
end

function var_0_0.onClickItem(arg_16_0)
	local var_16_0 = arg_16_0.view
	local var_16_1 = arg_16_0.index
	local var_16_2 = var_16_0._summonResultList[var_16_1]

	if var_16_2.heroId and var_16_2.heroId ~= 0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			showHome = false,
			heroId = var_16_2.heroId
		})
	elseif var_16_2.equipId and var_16_2.equipId ~= 0 then
		EquipController.instance:openEquipView({
			equipId = var_16_2.equipId
		})
	elseif var_16_2:isLuckyBag() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagGoMainViewOpen)
	end
end

function var_0_0._tweenFinish(arg_17_0)
	arg_17_0._cantClose = false
end

function var_0_0.onSummonReply(arg_18_0)
	arg_18_0:closeThis()
end

function var_0_0.onSummonSave(arg_19_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_19_0.onSaveViewClose, arg_19_0)
end

function var_0_0.onSaveViewClose(arg_20_0, arg_20_1)
	if arg_20_1 == ViewName.SummonSimulationPickView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_20_0.onSaveViewClose, arg_20_0)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2SummonSimulation.play_ui_checkpoint_doom_disappear)
		arg_20_0:_refreshSelectState()
	end
end

function var_0_0._refreshUI(arg_21_0)
	local var_21_0 = VirtualSummonScene.instance:isOpen()

	gohelper.setActive(arg_21_0._simagebg0, not var_21_0)

	for iter_21_0 = 1, #arg_21_0._summonResultList do
		local var_21_1 = arg_21_0._summonResultList[iter_21_0]

		if var_21_1.heroId and var_21_1.heroId ~= 0 then
			arg_21_0:_refreshHeroItem(arg_21_0._heroItemTables[iter_21_0], var_21_1)
		elseif var_21_1.equipId and var_21_1.equipId ~= 0 then
			arg_21_0:_refreshEquipItem(arg_21_0._heroItemTables[iter_21_0], var_21_1)
		elseif var_21_1:isLuckyBag() then
			arg_21_0:_refreshLuckyBagItem(arg_21_0._heroItemTables[iter_21_0], var_21_1)
		else
			gohelper.setActive(arg_21_0._heroItemTables[iter_21_0].go, false)
		end
	end

	for iter_21_1 = #arg_21_0._summonResultList + 1, #arg_21_0._heroItemTables do
		gohelper.setActive(arg_21_0._heroItemTables[iter_21_1].go, false)
	end

	arg_21_0:_refreshSelectState()
end

function var_0_0._refreshSelectState(arg_22_0)
	local var_22_0 = SummonSimulationPickController.instance:getCurrentSummonActivityId()

	arg_22_0._activityId = var_22_0

	local var_22_1 = SummonSimulationPickModel.instance:getActInfo(var_22_0)

	if not var_22_1 then
		return
	end

	local var_22_2 = SummonSimulationPickModel.instance:getActivityMaxSummonCount(var_22_0)
	local var_22_3 = var_22_1.leftTimes

	arg_22_0._txtresttime.text = string.format("<size=46><#C66030>%s</color></size>/%s", var_22_3, var_22_2)

	local var_22_4 = var_22_3 <= 0
	local var_22_5 = var_22_1:haveSaveCurrent()

	gohelper.setActive(arg_22_0._btnsave, not var_22_4)
	gohelper.setActive(arg_22_0._btnconfirm, not var_22_4)
	gohelper.setActive(arg_22_0._gosaved, var_22_5 and not var_22_4)

	local var_22_6 = var_22_4 and luaLang(arg_22_0.SUMMON_CONFIRM_TEXT) or luaLang(arg_22_0.SUMMON_AGAIN_TEXT)

	arg_22_0._txtagain.text = var_22_6

	local var_22_7 = var_22_5 and not arg_22_0._isReprint
	local var_22_8 = arg_22_0._goSaveAnimator

	var_22_8.enabled = var_22_7

	if var_22_7 then
		if var_22_3 == var_22_2 - 1 then
			local var_22_9 = arg_22_0.FIRST_SAVE_ANIM_DELAY

			TaskDispatcher.runDelay(arg_22_0.delayPlayBtnAnim, arg_22_0, var_22_9)
		else
			var_22_8:Play(arg_22_0.SAVED_ANIM_NAME, 0, 0)
		end
	end
end

function var_0_0.delayPlayBtnAnim(arg_23_0)
	arg_23_0._goSaveAnimator:Play(arg_23_0.SAVED_ANIM_NAME, 0, 0)
	GameFacade.showToast(ToastEnum.SummonSimulationSaveResult)
	TaskDispatcher.cancelTask(arg_23_0.delayPlayBtnAnim, arg_23_0)
end

local function var_0_1(arg_24_0)
	if not gohelper.isNil(arg_24_0.imageicon) then
		arg_24_0.imageicon:SetNativeSize()
	end
end

function var_0_0._refreshEquipItem(arg_25_0, arg_25_1, arg_25_2)
	gohelper.setActive(arg_25_1.goHeroIcon, false)
	gohelper.setActive(arg_25_1.simageequipicon.gameObject, true)
	gohelper.setActive(arg_25_1.goluckybag, false)
	gohelper.setActive(arg_25_1.txtname, true)
	gohelper.setActive(arg_25_1.txtnameen, true)

	local var_25_0 = arg_25_2.equipId
	local var_25_1 = EquipConfig.instance:getEquipCo(var_25_0)

	arg_25_1.txtname.text = var_25_1.name
	arg_25_1.txtnameen.text = var_25_1.name_en

	UISpriteSetMgr.instance:setSummonSprite(arg_25_1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[var_25_1.rare]))
	UISpriteSetMgr.instance:setSummonSprite(arg_25_1.equiprare, "equiprare_" .. tostring(CharacterEnum.Color[var_25_1.rare]))
	gohelper.setActive(arg_25_1.imagecareer.gameObject, false)
	gohelper.setActive(arg_25_1.simageicon.gameObject, false)
	arg_25_1.simageequipicon:LoadImage(ResUrl.getSummonEquipGetIcon(var_25_1.icon), var_0_1, arg_25_1)
	EquipHelper.loadEquipCareerNewIcon(var_25_1, arg_25_1.imageequipcareer, 1, "lssx")
	arg_25_0:_refreshEffect(var_25_1.rare, arg_25_1)
	gohelper.setActive(arg_25_1.go, true)
end

function var_0_0._refreshHeroItem(arg_26_0, arg_26_1, arg_26_2)
	gohelper.setActive(arg_26_1.imageequipcareer.gameObject, false)
	gohelper.setActive(arg_26_1.goHeroIcon, true)
	gohelper.setActive(arg_26_1.goluckybag, false)
	gohelper.setActive(arg_26_1.txtname, true)
	gohelper.setActive(arg_26_1.txtnameen, true)

	local var_26_0 = arg_26_2.heroId
	local var_26_1 = HeroConfig.instance:getHeroCO(var_26_0)
	local var_26_2 = SkinConfig.instance:getSkinCo(var_26_1.skinId)

	gohelper.setActive(arg_26_1.equiprare.gameObject, false)
	gohelper.setActive(arg_26_1.simageequipicon.gameObject, false)

	arg_26_1.txtname.text = var_26_1.name
	arg_26_1.txtnameen.text = var_26_1.nameEng

	UISpriteSetMgr.instance:setSummonSprite(arg_26_1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[var_26_1.rare]))
	UISpriteSetMgr.instance:setCommonSprite(arg_26_1.imagecareer, "lssx_" .. tostring(var_26_1.career))
	arg_26_1.simageicon:LoadImage(ResUrl.getHeadIconMiddle(var_26_2.retangleIcon))

	if arg_26_1.effect then
		gohelper.destroy(arg_26_1.effect)

		arg_26_1.effect = nil
	end

	arg_26_0:_refreshEffect(var_26_1.rare, arg_26_1)
	gohelper.setActive(arg_26_1.go, true)
end

function var_0_0._refreshLuckyBagItem(arg_27_0, arg_27_1, arg_27_2)
	gohelper.setActive(arg_27_1.goluckybag, true)
	gohelper.setActive(arg_27_1.equiprare.gameObject, false)
	gohelper.setActive(arg_27_1.simageequipicon.gameObject, false)
	gohelper.setActive(arg_27_1.imagecareer.gameObject, false)
	gohelper.setActive(arg_27_1.simageicon.gameObject, false)
	gohelper.setActive(arg_27_1.txtname, false)
	gohelper.setActive(arg_27_1.txtnameen, false)

	local var_27_0 = arg_27_2.luckyBagId

	if not arg_27_0._curPool then
		return
	end

	local var_27_1 = SummonConfig.instance:getLuckyBag(arg_27_0._curPool.id, var_27_0)

	arg_27_1.txtluckybagname.text = var_27_1.name
	arg_27_1.txtluckybagnameen.text = var_27_1.nameEn or ""

	arg_27_1.simageluckgbagicon:LoadImage(ResUrl.getSummonCoverBg(var_27_1.icon))
	UISpriteSetMgr.instance:setSummonSprite(arg_27_1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[SummonEnum.LuckyBagRare]))
	arg_27_0:_refreshEffect(SummonEnum.LuckyBagRare, arg_27_1)
	gohelper.setActive(arg_27_1.go, true)
end

function var_0_0._refreshEffect(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0

	if arg_28_1 == 3 then
		var_28_0 = arg_28_0.viewContainer:getSetting().otherRes[1]
	elseif arg_28_1 == 4 then
		var_28_0 = arg_28_0.viewContainer:getSetting().otherRes[2]
	elseif arg_28_1 == 5 then
		var_28_0 = arg_28_0.viewContainer:getSetting().otherRes[3]
	end

	if var_28_0 then
		arg_28_2.effect = arg_28_0.viewContainer:getResInst(var_28_0, arg_28_2.goeffect, "effect")

		arg_28_2.effect:GetComponent(typeof(UnityEngine.Animation)):PlayQueued("ssr_loop", UnityEngine.QueueMode.CompleteOthers)
	end
end

function var_0_0.onUpdateParam(arg_29_0)
	local var_29_0 = arg_29_0.viewParam.summonResultList

	arg_29_0._summonResultList = {}
	arg_29_0._curPool = arg_29_0.viewParam.curPool

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		table.insert(arg_29_0._summonResultList, iter_29_1)
	end

	if arg_29_0._curPool then
		SummonModel.sortResult(arg_29_0._summonResultList, arg_29_0._curPool.id)
	end

	arg_29_0:_refreshUI()
end

function var_0_0._showCommonPropView(arg_30_0)
	local var_30_0 = arg_30_0._activityId
	local var_30_1 = SummonSimulationPickModel.instance:getActInfo(var_30_0)

	if var_30_1.isSelect == false then
		if VirtualSummonScene.instance:isOpen() then
			if arg_30_0.isClickBack then
				return false
			elseif arg_30_0.isSummon then
				return true
			end
		end

		return not arg_30_0._isReprint
	end

	local var_30_2 = var_30_1.saveHeroIds
	local var_30_3 = SummonController.instance:getVirtualSummonResult(var_30_2, false, true)

	if var_30_3 == nil then
		return false
	end

	local var_30_4 = SummonSimulationPickController.instance

	SummonController.instance:setSummonEndOpenCallBack(var_30_4.backHome, var_30_4)

	local var_30_5 = SummonModel.getRewardList(var_30_3, true)

	table.sort(var_30_5, SummonModel.sortRewards)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_30_5)

	return true
end

return var_0_0
