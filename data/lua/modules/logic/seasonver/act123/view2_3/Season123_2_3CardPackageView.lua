module("modules.logic.seasonver.act123.view2_3.Season123_2_3CardPackageView", package.seeall)

local var_0_0 = class("Season123_2_3CardPackageView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocardpackage = gohelper.findChild(arg_1_0.viewGO, "#go_cardpackage")
	arg_1_0._gocardgetBtns = gohelper.findChild(arg_1_0.viewGO, "#go_cardpackage/cardgetBtns")
	arg_1_0._gopackageCount = gohelper.findChild(arg_1_0.viewGO, "#go_cardpackage/cardpackage/package/#go_packageCount")
	arg_1_0._txtpackageCount = gohelper.findChildText(arg_1_0.viewGO, "#go_cardpackage/cardpackage/package/#go_packageCount/#txt_packageCount")
	arg_1_0._btnopenPackage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cardpackage/cardgetBtns/#btn_openPackage")
	arg_1_0._btnopenOnePackage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cardpackage/cardgetBtns/#btn_openOnePackage")
	arg_1_0._btnopenAllPackage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cardpackage/cardgetBtns/#btn_openAllPackage")
	arg_1_0._gowaitingOpen = gohelper.findChild(arg_1_0.viewGO, "#go_cardpackage/#go_waitingOpen")
	arg_1_0._gorealOpen = gohelper.findChild(arg_1_0.viewGO, "#go_cardpackage/#go_waitingOpen/#drag_realOpen")
	arg_1_0._gocardget = gohelper.findChild(arg_1_0.viewGO, "#go_cardget")
	arg_1_0._scrollcardget = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_cardget/mask/#scroll_cardget")
	arg_1_0._gocardContent = gohelper.findChild(arg_1_0.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent")
	arg_1_0._gocarditem = gohelper.findChild(arg_1_0.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent/#go_carditem")
	arg_1_0._btnquit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cardget/#btn_quit")
	arg_1_0._btnopenNext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cardget/cardgetBtns/#btn_openNext")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")
	arg_1_0._imageskip = gohelper.findChildImage(arg_1_0.viewGO, "#btn_skip/#image_skip")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._goopenEffect = gohelper.findChild(arg_1_0.viewGO, "#go_cardpackage/cardpackage/package/openup")
	arg_1_0._goopenLineEffect = gohelper.findChild(arg_1_0.viewGO, "#go_cardpackage/cardpackage/package/kabao/go_line")
	arg_1_0._animator = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._dragrealOpen = SLFramework.UGUI.UIDragListener.Get(arg_1_0._gorealOpen)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnopenPackage:AddClickListener(arg_2_0._btnopenPackageOnClick, arg_2_0)
	arg_2_0._btnopenOnePackage:AddClickListener(arg_2_0._btnopenOnePackageOnClick, arg_2_0)
	arg_2_0._btnopenAllPackage:AddClickListener(arg_2_0._btnopenAllPackageOnClick, arg_2_0)
	arg_2_0._dragrealOpen:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._dragrealOpen:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0._btnquit:AddClickListener(arg_2_0._btnquitOnClick, arg_2_0)
	arg_2_0._btnopenNext:AddClickListener(arg_2_0._btnopenNextOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0:addEventCb(Season123Controller.instance, Season123Event.OnCardPackageOpen, arg_2_0.showWaitingOpenView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnopenPackage:RemoveClickListener()
	arg_3_0._btnopenOnePackage:RemoveClickListener()
	arg_3_0._btnopenAllPackage:RemoveClickListener()
	arg_3_0._dragrealOpen:RemoveDragBeginListener()
	arg_3_0._dragrealOpen:RemoveDragEndListener()
	arg_3_0._btnquit:RemoveClickListener()
	arg_3_0._btnopenNext:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0:removeEventCb(Season123Controller.instance, Season123Event.OnCardPackageOpen, arg_3_0.showWaitingOpenView, arg_3_0)
end

var_0_0.hideCardPackageTime = 0.33

function var_0_0._btnopenPackageOnClick(arg_4_0)
	arg_4_0:openCardPackage()
end

function var_0_0._btnopenOnePackageOnClick(arg_5_0)
	arg_5_0:openCardPackage()
end

function var_0_0._btnopenAllPackageOnClick(arg_6_0)
	if arg_6_0.hasClickOpen then
		return
	end

	Activity123Rpc.instance:sendAct123OpenCardBagRequest(arg_6_0.actId, Activity123Enum.openAllCardPackage)
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(arg_6_0.actId)
end

function var_0_0._onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._startPos = arg_7_2.position.x
end

function var_0_0._onDragEnd(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2.position.x
	local var_8_1 = recthelper.getWidth(arg_8_0._gorealOpen.transform) / 4

	if var_8_0 > arg_8_0._startPos and var_8_1 <= Mathf.Abs(var_8_0 - arg_8_0._startPos) then
		arg_8_0:playOpenCardAnim()
		gohelper.setActive(arg_8_0._gowaitingOpen, false)
	end
end

function var_0_0._btnskipOnClick(arg_9_0)
	if arg_9_0.hasClickSkip then
		return
	end

	arg_9_0._animator:Stop()
	arg_9_0._animator:Play("kabao_skip", arg_9_0.showCardGetView, arg_9_0)

	local var_9_0 = Season123CardPackageModel.instance:getCardMaxRare()

	for iter_9_0 = 2, 5 do
		gohelper.setActive(arg_9_0.rareEffectList[iter_9_0], iter_9_0 == var_9_0)
	end

	arg_9_0.hasClickSkip = true
end

function var_0_0._btnquitOnClick(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._btnopenNextOnClick(arg_11_0)
	arg_11_0:openCardPackage()
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.rareEffectList = arg_12_0:getUserDataTb_()
	arg_12_0.rareLineEffectList = arg_12_0:getUserDataTb_()
	arg_12_0.actId = Season123Model.instance:getCurSeasonId()
	arg_12_0.contentGrid = arg_12_0._gocardContent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))

	for iter_12_0 = 2, 5 do
		local var_12_0 = gohelper.findChild(arg_12_0._goopenEffect, "go_rare" .. iter_12_0)
		local var_12_1 = gohelper.findChild(arg_12_0._goopenLineEffect, "go_rare" .. iter_12_0)

		arg_12_0.rareEffectList[iter_12_0] = var_12_0
		arg_12_0.rareLineEffectList[iter_12_0] = var_12_1

		gohelper.setActive(var_12_0, false)
		gohelper.setActive(var_12_1, false)
	end

	arg_12_0.hasClickSkip = false
	arg_12_0.hasClickOpen = false
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:refreshCardPackageUI()
	gohelper.setActive(arg_13_0._gocardgetBtns, true)
	gohelper.setActive(arg_13_0._btnskip.gameObject, false)
	gohelper.setActive(arg_13_0._gowaitingOpen, false)
	gohelper.setActive(arg_13_0._gobtns, true)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_cardpacks_unfold)
end

function var_0_0.refreshCardPackageUI(arg_14_0)
	gohelper.setActive(arg_14_0._gocardpackage, true)
	gohelper.setActive(arg_14_0._gocardget, false)

	arg_14_0.curPackageCount = Season123CardPackageModel.instance:initPackageCount()
	arg_14_0._txtpackageCount.text = arg_14_0.curPackageCount

	gohelper.setActive(arg_14_0._btnopenPackage.gameObject, arg_14_0.curPackageCount == 1)
	gohelper.setActive(arg_14_0._btnopenOnePackage.gameObject, arg_14_0.curPackageCount > 1)
	gohelper.setActive(arg_14_0._btnopenAllPackage.gameObject, arg_14_0.curPackageCount > 1)
end

function var_0_0.showWaitingOpenView(arg_15_0)
	arg_15_0._animator:Play("kabao_wait")
	arg_15_0:refreshCardPackageUI()
	gohelper.setActive(arg_15_0._gowaitingOpen, true)
	gohelper.setActive(arg_15_0._gocardgetBtns, false)
	gohelper.setActive(arg_15_0._gobtns, false)
end

function var_0_0.playOpenCardAnim(arg_16_0)
	arg_16_0:refreshCardPackageUI()
	gohelper.setActive(arg_16_0._btnskip.gameObject, true)
	gohelper.setActive(arg_16_0._gocardgetBtns, false)
	arg_16_0._animator:Play("kabao_open", arg_16_0.showCardGetView, arg_16_0)

	arg_16_0.openCardPackageAudioId = AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_cardpacks_open)

	local var_16_0 = Season123CardPackageModel.instance:getCardMaxRare()

	for iter_16_0 = 2, 5 do
		gohelper.setActive(arg_16_0.rareEffectList[iter_16_0], iter_16_0 == var_16_0)
		gohelper.setActive(arg_16_0.rareLineEffectList[iter_16_0], iter_16_0 == var_16_0)
	end
end

function var_0_0.showCardGetView(arg_17_0)
	arg_17_0:refreshCardGetUI()
	TaskDispatcher.runDelay(arg_17_0.hideCardPackageView, arg_17_0, var_0_0.hideCardPackageTime)

	if arg_17_0.hasClickSkip then
		arg_17_0:stopOpenCardPackageAudio()
	end

	Season123Controller.instance:dispatchEvent(Season123Event.GotCardView)
end

function var_0_0.hideCardPackageView(arg_18_0)
	gohelper.setActive(arg_18_0._gocardpackage, false)

	arg_18_0.hasClickSkip = false
end

function var_0_0.refreshCardGetUI(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_get)
	gohelper.setActive(arg_19_0._gocardget, true)
	gohelper.setActive(arg_19_0._btnskip.gameObject, false)
	arg_19_0:refreshScrollPos()
	gohelper.setActive(arg_19_0._btnopenNext, arg_19_0.curPackageCount > 0)
	gohelper.setActive(arg_19_0._btnquit, true)
	gohelper.setActive(arg_19_0._gobtns, false)

	arg_19_0.hasClickOpen = false
end

function var_0_0.refreshScrollPos(arg_20_0)
	if Season123CardPackageModel.instance:getCount() <= 6 then
		arg_20_0.contentGrid.enabled = false
		arg_20_0.contentGrid.enabled = true

		transformhelper.setLocalPosXY(arg_20_0._scrollcardget.transform, 0, -680)
	else
		arg_20_0.contentGrid.enabled = false

		transformhelper.setLocalPosXY(arg_20_0._scrollcardget.transform, 0, -570)
	end
end

function var_0_0.openCardPackage(arg_21_0)
	if arg_21_0.hasClickOpen then
		return
	end

	arg_21_0.hasClickOpen = true

	local var_21_0 = Season123CardPackageModel.instance:getOpenPackageMO()

	Activity123Rpc.instance:sendAct123OpenCardBagRequest(arg_21_0.actId, var_21_0.id)
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(arg_21_0.actId)
	arg_21_0:stopOpenCardPackageAudio()
end

function var_0_0.stopOpenCardPackageAudio(arg_22_0)
	if arg_22_0.openCardPackageAudioId then
		AudioMgr.instance:stopPlayingID(arg_22_0.openCardPackageAudioId)

		arg_22_0.openCardPackageAudioId = nil
	end
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.hideCardPackageView, arg_23_0)
	arg_23_0:stopOpenCardPackageAudio()
end

function var_0_0.onDestroyView(arg_24_0)
	Season123CardPackageModel.instance:release()
end

return var_0_0
