module("modules.logic.sp01.odyssey.view.OdysseyDungeonView", package.seeall)

local var_0_0 = class("OdysseyDungeonView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._btnInteractClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_interactClose")
	arg_1_0._gomapName = gohelper.findChild(arg_1_0.viewGO, "root/#go_mapName")
	arg_1_0._txtmapName = gohelper.findChildText(arg_1_0.viewGO, "root/#go_mapName/#txt_mapName")
	arg_1_0._scrolltask = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_task")
	arg_1_0._gotaskContent = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_task/Viewport/#go_taskContent")
	arg_1_0._gotaskItem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_task/Viewport/#go_taskContent/#go_taskItem")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_level")
	arg_1_0._gotask = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_task")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_task/#btn_task")
	arg_1_0._gotaskReddot = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_task/#go_taskReddot")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom")
	arg_1_0._btnmyth = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/btnContent/#btn_myth")
	arg_1_0._btnreligion = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/btnContent/#btn_religion")
	arg_1_0._btnbackpack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/btnContent/#btn_backpack")
	arg_1_0._btnherogroup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/btnContent/#btn_herogroup")
	arg_1_0._btndatabase = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/btnContent/#btn_database")
	arg_1_0._btnshowhide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/#btn_showhide")
	arg_1_0._gomercenary = gohelper.findChild(arg_1_0.viewGO, "root/#go_mercenary")
	arg_1_0._imageprogressBar = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_mercenary/#image_progressBar")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_mercenary/#image_progressBar/#image_progress")
	arg_1_0._gomercenaryContent = gohelper.findChild(arg_1_0.viewGO, "root/#go_mercenary/#image_progressBar/#go_mercenaryContent")
	arg_1_0._gomercenaryItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_mercenary/#image_progressBar/#go_mercenaryContent/#go_mercenaryItem")
	arg_1_0._btnmercenaryJump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_mercenary/#btn_mercenaryJump")
	arg_1_0._btnmercenaryTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_mercenary/#btn_mercenaryTip")
	arg_1_0._gomercenaryTip = gohelper.findChild(arg_1_0.viewGO, "root/#go_mercenary/#go_mercenaryTip")
	arg_1_0._txtnextTime = gohelper.findChildText(arg_1_0.viewGO, "root/#go_mercenary/#go_mercenaryTip/bg/#txt_nextTime")
	arg_1_0._txttotalTime = gohelper.findChildText(arg_1_0.viewGO, "root/#go_mercenary/#go_mercenaryTip/bg/#txt_totalTime")
	arg_1_0._btncloseMercenaryTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_mercenary/#go_mercenaryTip/#btn_closeMercenaryTip")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._btnMapSelect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_mapSelect/#btn_mapSelect")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "root/#go_arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnmyth:AddClickListener(arg_2_0._btnmythOnClick, arg_2_0)
	arg_2_0._btnreligion:AddClickListener(arg_2_0._btnreligionOnClick, arg_2_0)
	arg_2_0._btnbackpack:AddClickListener(arg_2_0._btnbackpackOnClick, arg_2_0)
	arg_2_0._btnherogroup:AddClickListener(arg_2_0._btnherogroupOnClick, arg_2_0)
	arg_2_0._btndatabase:AddClickListener(arg_2_0._btndatabaseOnClick, arg_2_0)
	arg_2_0._btnshowhide:AddClickListener(arg_2_0._btnshowhideOnClick, arg_2_0)
	arg_2_0._btnmercenaryTip:AddClickListener(arg_2_0._btnmercenaryTipOnClick, arg_2_0)
	arg_2_0._btnmercenaryJump:AddClickListener(arg_2_0._btnmercenaryJumpOnClick, arg_2_0)
	arg_2_0._btncloseMercenaryTip:AddClickListener(arg_2_0._btncloseMercenaryTipOnClick, arg_2_0)
	arg_2_0._btnMainTask:AddClickListener(arg_2_0._btnmainTaskOnClick, arg_2_0)
	arg_2_0._btnMapSelect:AddClickListener(arg_2_0._btnmapSelectOnClick, arg_2_0)
	arg_2_0._btnInteractClose:AddClickListener(arg_2_0._btnInteractCloseOnClick, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementPush, arg_2_0.onUpdateElementPush, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnRewardGet, arg_2_0.refreshBottomBtnShow, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnMapSelectItemEnter, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.DailyRefresh, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnRewardGet, arg_2_0.popupRewardView, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, arg_2_0.refreshMapSelectUI, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnMapUpdate, arg_2_0.refreshMapSelectUI, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.SetDungeonUIShowState, arg_2_0.setInteractEleUIShowState, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonRightUI, arg_2_0.showRightUI, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnRefreshReddot, arg_2_0.refreshReddot, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnRefreshReddot, arg_2_0.checkAndAutoExposeReligion, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateLibraryReddot, arg_2_0.refreshReddot, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonBagGetEffect, arg_2_0.showDungeonBagGetEffect, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonTalentGetEffect, arg_2_0.showDungeonTalentGetEffect, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowInteractCloseBtn, arg_2_0.showInteractCloseBtn, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.PlaySubTaskFinishEffect, arg_2_0.playFinishSubTaskItemEffect, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.PlaySubTaskShowEffect, arg_2_0.playSubTaskItemShowEffect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnmyth:RemoveClickListener()
	arg_3_0._btnreligion:RemoveClickListener()
	arg_3_0._btnbackpack:RemoveClickListener()
	arg_3_0._btnherogroup:RemoveClickListener()
	arg_3_0._btndatabase:RemoveClickListener()
	arg_3_0._btnshowhide:RemoveClickListener()
	arg_3_0._btnmercenaryTip:RemoveClickListener()
	arg_3_0._btnmercenaryJump:RemoveClickListener()
	arg_3_0._btncloseMercenaryTip:RemoveClickListener()
	arg_3_0._btnMainTask:RemoveClickListener()
	arg_3_0._btnMapSelect:RemoveClickListener()
	arg_3_0._btnInteractClose:RemoveClickListener()
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementPush, arg_3_0.onUpdateElementPush, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnRewardGet, arg_3_0.refreshBottomBtnShow, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnMapSelectItemEnter, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.DailyRefresh, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnRewardGet, arg_3_0.popupRewardView, arg_3_0)
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, arg_3_0.refreshMapSelectUI, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnMapUpdate, arg_3_0.refreshMapSelectUI, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.SetDungeonUIShowState, arg_3_0.setInteractEleUIShowState, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonRightUI, arg_3_0.showRightUI, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnRefreshReddot, arg_3_0.refreshReddot, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnRefreshReddot, arg_3_0.checkAndAutoExposeReligion, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.UpdateLibraryReddot, arg_3_0.refreshReddot, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonBagGetEffect, arg_3_0.showDungeonBagGetEffect, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonTalentGetEffect, arg_3_0.showDungeonTalentGetEffect, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowInteractCloseBtn, arg_3_0.showInteractCloseBtn, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.PlaySubTaskFinishEffect, arg_3_0.playFinishSubTaskItemEffect, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.PlaySubTaskShowEffect, arg_3_0.playSubTaskItemShowEffect, arg_3_0)
end

function var_0_0._btnmercenaryJumpOnClick(arg_4_0)
	arg_4_0.curMapId = OdysseyDungeonModel.instance:getCurMapId()

	local var_4_0 = OdysseyDungeonModel.instance:getIsInMapSelectState()

	if arg_4_0.curMercenaryCount == 0 or var_4_0 then
		return
	end

	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnmercenaryJumpOnClick")

	local var_4_1 = OdysseyDungeonModel.instance:getMercenaryElementsByMap(arg_4_0.curMapId)

	if #var_4_1 == 0 then
		if not var_4_0 then
			arg_4_0:_btnmapSelectOnClick()
		end
	else
		local var_4_2 = var_4_1[1].config.id

		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, var_4_2)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, var_4_2, OdysseyEnum.ElementAnimName.Tips)
	end
end

function var_0_0._btnmercenaryTipOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gomercenaryTip, true)
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnmercenaryTipOnClick")
end

function var_0_0._btncloseMercenaryTipOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._gomercenaryTip, false)
end

function var_0_0._btnmapSelectOnClick(arg_7_0)
	arg_7_0:setChangeMapUIState(false)
	OdysseyDungeonModel.instance:setIsMapSelect(true)
	gohelper.setActive(arg_7_0._gomapName, false)
	arg_7_0.viewContainer:getDungeonSceneView():refreshMapSelectView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnmapSelectOnClick")
end

function var_0_0._btntaskOnClick(arg_8_0)
	OdysseyController.instance:openTaskView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btntaskOnClick")
end

function var_0_0._btnmythOnClick(arg_9_0)
	arg_9_0:_btnInteractCloseOnClick()
	OdysseyDungeonController.instance:openMythView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnmythOnClick")
end

function var_0_0._btnreligionOnClick(arg_10_0)
	arg_10_0:_btnInteractCloseOnClick()
	OdysseyDungeonController.instance:openMembersView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnreligionOnClick")
end

function var_0_0._btnbackpackOnClick(arg_11_0)
	arg_11_0:_btnInteractCloseOnClick()
	OdysseyController.instance:openBagView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnbackpackOnClick")
end

function var_0_0._btnherogroupOnClick(arg_12_0)
	arg_12_0:_btnInteractCloseOnClick()
	OdysseyController.instance:openHeroGroupView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnherogroupOnClick")
end

function var_0_0._btndatabaseOnClick(arg_13_0)
	arg_13_0:_btnInteractCloseOnClick()
	OdysseyController.instance:openLibraryView(AssassinEnum.LibraryType.Hero)
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btndatabaseOnClick")
end

function var_0_0._btnshowhideOnClick(arg_14_0)
	arg_14_0:_btnInteractCloseOnClick()

	if arg_14_0.isShowBtnContent then
		arg_14_0._animBottom:Play("close", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_list_fold)
	else
		arg_14_0._animBottom:Play("open", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_list_unfold)
	end

	arg_14_0.isShowBtnContent = not arg_14_0.isShowBtnContent

	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnshowhideOnClick#" .. tostring(arg_14_0.isShowBtnContent))
end

function var_0_0._btnmainTaskOnClick(arg_15_0)
	local var_15_0, var_15_1 = OdysseyDungeonModel.instance:getCurMainElement()

	arg_15_0.curMapId = OdysseyDungeonModel.instance:getCurMapId()

	if var_15_1 then
		if var_15_1.mapId == arg_15_0.curMapId then
			OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, var_15_1.id)
			OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, var_15_1.id, OdysseyEnum.ElementAnimName.Tips)
		else
			local var_15_2 = OdysseyDungeonModel.instance:getIsInMapSelectState()

			OdysseyDungeonModel.instance:setNeedFocusMainMapSelectItem(true)

			if not var_15_2 then
				arg_15_0:_btnmapSelectOnClick()
			else
				local var_15_3 = arg_15_0.viewContainer:getDungeonMapSelectView()

				if var_15_3 then
					var_15_3:onFocusMainMapSelectItem(true)
				end
			end
		end

		OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnmainTaskOnClick#" .. var_15_1.id)
	else
		GameFacade.showToast(ToastEnum.OdysseyElementLock)
	end
end

function var_0_0.onSubTaskItemClick(arg_16_0, arg_16_1)
	arg_16_0.curMapId = OdysseyDungeonModel.instance:getCurMapId()

	if arg_16_1 and arg_16_1.elementMo and arg_16_1.elementMo.config and arg_16_1.elementMo.config.mapId == arg_16_0.curMapId then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, arg_16_1.elementMo.config.id)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, arg_16_1.elementMo.config.id, OdysseyEnum.ElementAnimName.Tips)
		OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("onSubTaskItemClick#" .. arg_16_1.elementMo.config.id)
	end
end

function var_0_0._btnInteractCloseOnClick(arg_17_0)
	ViewMgr.instance:closeView(ViewName.OdysseyDungeonInteractView)
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._goRight = gohelper.findChild(arg_18_0.viewGO, "root/right")
	arg_18_0._goMainTaskItem = gohelper.findChild(arg_18_0._gotaskItem, "go_main")
	arg_18_0._goSubTaskItemContent = gohelper.findChild(arg_18_0._gotaskItem, "go_sub")
	arg_18_0._txtTaskName = gohelper.findChildText(arg_18_0._gotaskItem, "go_main/taskName/txt_taskName")
	arg_18_0._btnMainTask = gohelper.findChildButtonWithAudio(arg_18_0._gotaskItem, "go_main")
	arg_18_0._txtTaskDesc = gohelper.findChildText(arg_18_0._gotaskItem, "go_main/taskDesc/txt_taskDesc")
	arg_18_0._goSubTaskItem = gohelper.findChild(arg_18_0._gotaskItem, "go_sub/go_subTaskItem")
	arg_18_0._goshowhideIcon = gohelper.findChild(arg_18_0.viewGO, "root/#go_bottom/#btn_showhide/icon")
	arg_18_0._gobtnContent = gohelper.findChild(arg_18_0.viewGO, "root/#go_bottom/btnContent")
	arg_18_0._gomythReddot = gohelper.findChild(arg_18_0._btnmyth.gameObject, "go_reddot")
	arg_18_0._goreligionReddot = gohelper.findChild(arg_18_0._btnreligion.gameObject, "go_reddot")
	arg_18_0._gobackpackReddot = gohelper.findChild(arg_18_0._btnbackpack.gameObject, "go_reddot")
	arg_18_0._goherogroupReddot = gohelper.findChild(arg_18_0._btnherogroup.gameObject, "go_reddot")
	arg_18_0._godatabaseReddot = gohelper.findChild(arg_18_0._btndatabase.gameObject, "go_reddot")
	arg_18_0._goMapSelectReddot = gohelper.findChild(arg_18_0._btnMapSelect.gameObject, "go_reddot")
	arg_18_0._animBottom = arg_18_0._gobottom:GetComponent(gohelper.Type_Animator)
	arg_18_0._gobackpackEffect = gohelper.findChild(arg_18_0._btnbackpack.gameObject, "#effect_get")
	arg_18_0._goherogroupEffect = gohelper.findChild(arg_18_0._btnherogroup.gameObject, "#effect_get")

	gohelper.setActive(arg_18_0._goSubTaskItem, false)
	gohelper.setActive(arg_18_0._gomercenaryItem, false)
	gohelper.setActive(arg_18_0._gomercenaryTip, false)
	gohelper.setActive(arg_18_0._goRight, true)
	gohelper.setActive(arg_18_0._btnInteractClose.gameObject, false)

	arg_18_0.isShowBtnContent = true
	arg_18_0.mercenaryItemMap = arg_18_0:getUserDataTb_()
	arg_18_0.hasExposeReligionMap = arg_18_0:getUserDataTb_()
	arg_18_0.subTaskItemMap = arg_18_0:getUserDataTb_()
	arg_18_0.subTaskShowEffectMap = arg_18_0:getUserDataTb_()

	OdysseyTaskModel.instance:setTaskInfoList()
	AssassinController.instance:dispatchEvent(AssassinEvent.EnableLibraryToast, false)
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	OdysseyStatHelper.instance:initDungeonStartTime()
	RedDotController.instance:addRedDot(arg_20_0._gotaskReddot, RedDotEnum.DotNode.OdysseyTask)
	arg_20_0._animBottom:Play("idle", 0, 0)
	arg_20_0:initConstData()
	arg_20_0:refreshUI()
	arg_20_0:refreshReddot()
	arg_20_0:refreshBottomBtnShow()
	arg_20_0:checkAndAutoExposeReligion()
end

var_0_0.MercenaryBarWidth = 442
var_0_0.MercenaryBarFirstWidth = 63
var_0_0.MercenaryBarItemSpace = 83

function var_0_0.initConstData(arg_21_0)
	local var_21_0 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MercenaryLimitedNum)

	arg_21_0.mercenaryMaxCount = tonumber(var_21_0.value)

	local var_21_1 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MercenaryRecoverSpeed)

	arg_21_0.recoverTimeStamp = tonumber(var_21_1.value) * TimeUtil.OneHourSecond
	arg_21_0.mercenaryUnlockCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MercenaryUnlock)
	arg_21_0.levelGO = arg_21_0.viewContainer:getResInst(arg_21_0.viewContainer:getSetting().otherRes[3], arg_21_0._golevel)
	arg_21_0.levelComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_21_0.levelGO, OdysseyDungeonLevelComp)
end

function var_0_0.refreshUI(arg_22_0)
	arg_22_0:refreshMapUI()
	arg_22_0:refreshMercenaryUI()
	arg_22_0:refreshTaskUI()
	arg_22_0:createAndRefreshSubTaskItem()
	arg_22_0:refreshMapSelectUI()
end

function var_0_0.refreshMapUI(arg_23_0)
	arg_23_0.curMapId = OdysseyDungeonModel.instance:getCurMapId()
	arg_23_0.mapConfig = OdysseyConfig.instance:getDungeonMapConfig(arg_23_0.curMapId)
	arg_23_0._txtmapName.text = arg_23_0.mapConfig.mapName

	arg_23_0.levelComp:refreshUI()
end

function var_0_0.refreshMercenaryUI(arg_24_0)
	arg_24_0.isMercenaryUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(arg_24_0.mercenaryUnlockCo.value)

	if not arg_24_0.isMercenaryUnlock then
		gohelper.setActive(arg_24_0._gomercenary, false)

		return
	end

	gohelper.setActive(arg_24_0._gomercenary, true)

	arg_24_0.curMercenaryEleMoList = OdysseyDungeonModel.instance:getCurMercenaryElements()
	arg_24_0.curMercenaryCount = #arg_24_0.curMercenaryEleMoList

	for iter_24_0 = 1, arg_24_0.mercenaryMaxCount do
		local var_24_0 = arg_24_0.mercenaryItemMap[iter_24_0]

		if not var_24_0 then
			var_24_0 = {
				go = gohelper.clone(arg_24_0._gomercenaryItem, arg_24_0._gomercenaryContent, "mercenaryItem" .. iter_24_0)
			}
			var_24_0.goEmpty = gohelper.findChild(var_24_0.go, "go_empty")
			var_24_0.goHas = gohelper.findChild(var_24_0.go, "go_has")
			arg_24_0.mercenaryItemMap[iter_24_0] = var_24_0
		end

		gohelper.setActive(var_24_0.go, true)
		gohelper.setActive(var_24_0.goEmpty, iter_24_0 > arg_24_0.curMercenaryCount)
		gohelper.setActive(var_24_0.goHas, iter_24_0 <= arg_24_0.curMercenaryCount)
	end

	arg_24_0:refreshMercenaryBar()

	if arg_24_0.curMercenaryCount < arg_24_0.mercenaryMaxCount then
		TaskDispatcher.cancelTask(arg_24_0.refreshMercenaryBar, arg_24_0)
		TaskDispatcher.runRepeat(arg_24_0.refreshMercenaryBar, arg_24_0, 1)
	end
end

function var_0_0.refreshMercenaryBar(arg_25_0)
	local var_25_0 = OdysseyModel.instance:getRemainMercenaryRefreshTime()

	if OdysseyModel.instance:getMercenaryNextRefreshTime() > 0 and var_25_0 <= 0 and arg_25_0.curMercenaryCount < arg_25_0.mercenaryMaxCount then
		OdysseyRpc.instance:sendOdysseyFightMercenaryRefreshRequest()
	end

	local var_25_1 = (arg_25_0.recoverTimeStamp - var_25_0) / arg_25_0.recoverTimeStamp
	local var_25_2 = 0

	if arg_25_0.curMercenaryCount == 0 then
		var_25_2 = var_0_0.MercenaryBarFirstWidth * var_25_1
	elseif arg_25_0.curMercenaryCount > 0 and arg_25_0.curMercenaryCount < arg_25_0.mercenaryMaxCount then
		var_25_2 = var_0_0.MercenaryBarFirstWidth + (arg_25_0.curMercenaryCount - 1) * var_0_0.MercenaryBarItemSpace + var_0_0.MercenaryBarItemSpace * var_25_1
	elseif arg_25_0.curMercenaryCount >= arg_25_0.mercenaryMaxCount then
		var_25_2 = var_0_0.MercenaryBarWidth
	end

	recthelper.setWidth(arg_25_0._imageprogress.transform, var_25_2)

	if arg_25_0.mercenaryMaxCount <= arg_25_0.curMercenaryCount then
		TaskDispatcher.cancelTask(arg_25_0.refreshMercenaryBar, arg_25_0)

		arg_25_0._txtnextTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_dungeon_mercenary_nexttime"), "--:--:--")
		arg_25_0._txttotalTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_dungeon_mercenary_totaltime"), "--:--:--")
	else
		local var_25_3 = Mathf.Max(arg_25_0.mercenaryMaxCount - arg_25_0.curMercenaryCount - 1, 0) * arg_25_0.recoverTimeStamp + var_25_0

		arg_25_0._txtnextTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_dungeon_mercenary_nexttime"), TimeUtil.second2TimeString(var_25_0, true))
		arg_25_0._txttotalTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_dungeon_mercenary_totaltime"), TimeUtil.second2TimeString(var_25_3, true))
	end
end

function var_0_0.refreshTaskUI(arg_26_0)
	local var_26_0, var_26_1 = OdysseyDungeonModel.instance:getCurMainElement()

	if var_26_1 then
		local var_26_2 = OdysseyConfig.instance:getMainTaskConfig(var_26_1.id)

		if var_26_2 then
			arg_26_0._txtTaskName.text = var_26_2.taskTitle
			arg_26_0._txtTaskDesc.text = var_26_1.taskDesc

			gohelper.setActive(arg_26_0._goMainTaskItem, true)
		else
			gohelper.setActive(arg_26_0._goMainTaskItem, false)
		end
	else
		gohelper.setActive(arg_26_0._goMainTaskItem, false)
	end
end

function var_0_0.createAndRefreshSubTaskItem(arg_27_0)
	if OdysseyDungeonModel.instance:getIsInMapSelectState() then
		return
	end

	local var_27_0 = {}

	arg_27_0.curMapId = OdysseyDungeonModel.instance:getCurMapId()

	local var_27_1 = OdysseyDungeonModel.instance:getMapNotFinishFightElementMoList(arg_27_0.curMapId, OdysseyEnum.FightType.Conquer)

	if #var_27_1 > 0 then
		tabletool.addValues(var_27_0, var_27_1)
	end

	local var_27_2 = OdysseyDungeonModel.instance:getMapNotFinishFightElementMoList(arg_27_0.curMapId, OdysseyEnum.FightType.Myth)

	if #var_27_2 > 0 then
		tabletool.addValues(var_27_0, var_27_2)
	end

	local var_27_3 = OdysseyDungeonModel.instance:getMapNotFinishFightElementMoList(arg_27_0.curMapId, OdysseyEnum.FightType.Religion)

	if #var_27_3 > 0 then
		tabletool.addValues(var_27_0, var_27_3)
	end

	local var_27_4 = OdysseyDungeonModel.instance:getLastElementFightParam()

	if var_27_4 and var_27_4.lastElementId > 0 then
		local var_27_5 = OdysseyDungeonModel.instance:getElementMo(var_27_4.lastElementId)
		local var_27_6 = OdysseyConfig.instance:getElementFightConfig(var_27_4.lastElementId)

		if OdysseyDungeonModel.instance:isElementFinish(var_27_4.lastElementId) and var_27_5 and var_27_6 and (var_27_6.type == OdysseyEnum.FightType.Conquer or var_27_6.type == OdysseyEnum.FightType.Myth or var_27_6.type == OdysseyEnum.FightType.Religion) then
			table.insert(var_27_0, var_27_5)
		end
	end

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		local var_27_7 = arg_27_0.subTaskItemMap[iter_27_0]

		if not var_27_7 then
			var_27_7 = {
				go = gohelper.clone(arg_27_0._goSubTaskItem, arg_27_0._goSubTaskItemContent, "rewardItem_" .. iter_27_0)
			}
			var_27_7.anim = var_27_7.go:GetComponent(typeof(UnityEngine.Animator))
			var_27_7.imageIcon = gohelper.findChildImage(var_27_7.go, "bg/#image_icon")
			var_27_7.txtTaskDesc = gohelper.findChildText(var_27_7.go, "txt_taskDesc")
			var_27_7.btnClick = gohelper.findChildButton(var_27_7.go, "btn_click")

			var_27_7.btnClick:AddClickListener(arg_27_0.onSubTaskItemClick, arg_27_0, var_27_7)

			var_27_7.finishEffect = gohelper.findChildImage(var_27_7.go, "bg/bg_glow")
			var_27_7.finishMaterial = var_27_7.finishEffect.material
			var_27_7.finishEffect.material = UnityEngine.Object.Instantiate(var_27_7.finishMaterial)
			var_27_7.materialPropsCtrl = var_27_7.go:GetComponent(typeof(ZProj.MaterialPropsCtrl))

			var_27_7.materialPropsCtrl.mas:Clear()
			var_27_7.materialPropsCtrl.mas:Add(var_27_7.finishEffect.material)

			arg_27_0.subTaskItemMap[iter_27_0] = var_27_7
		end

		gohelper.setActive(var_27_7.go, true)

		if not var_27_7.elementMo or var_27_7.elementMo.id ~= iter_27_1.id then
			gohelper.setActive(var_27_7.go, false)

			arg_27_0.subTaskShowEffectMap[iter_27_1.id] = var_27_7
		else
			var_27_7.anim:Play("idle", 0, 0)
		end

		var_27_7.anim:Update(0)

		var_27_7.elementMo = iter_27_1
		var_27_7.fightElementConfig = OdysseyConfig.instance:getElementFightConfig(iter_27_1.id)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(var_27_7.imageIcon, iter_27_1.config.icon)

		var_27_7.txtTaskDesc.text = var_27_7.fightElementConfig.title
	end

	for iter_27_2 = #var_27_0 + 1, #arg_27_0.subTaskItemMap do
		local var_27_8 = arg_27_0.subTaskItemMap[iter_27_2]

		if var_27_8 then
			gohelper.setActive(var_27_8.go, false)
			var_27_8.btnClick:RemoveClickListener()

			local var_27_9

			arg_27_0.subTaskItemMap[iter_27_2] = nil
		end
	end
end

function var_0_0.playSubTaskItemShowEffect(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.subTaskShowEffectMap) do
		if iter_28_1 then
			gohelper.setActive(iter_28_1.go, true)
			iter_28_1.anim:Play("open", 0, 0)
			iter_28_1.anim:Update(0)
		end
	end

	if next(arg_28_0.subTaskShowEffectMap) then
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_main_quest)
	end
end

function var_0_0.playFinishSubTaskItemEffect(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.subTaskItemMap) do
		if iter_29_1 and OdysseyDungeonModel.instance:isElementFinish(iter_29_1.elementMo.id) then
			iter_29_1.anim:Play("finish", 0, 0)
			iter_29_1.anim:Update(0)
		end
	end

	TaskDispatcher.cancelTask(arg_29_0.cleanFinishSubTaskItem, arg_29_0)
	TaskDispatcher.runDelay(arg_29_0.cleanFinishSubTaskItem, arg_29_0, 1)
end

function var_0_0.cleanFinishSubTaskItem(arg_30_0)
	for iter_30_0 = #arg_30_0.subTaskItemMap, 1, -1 do
		local var_30_0 = arg_30_0.subTaskItemMap[iter_30_0]

		if var_30_0 and OdysseyDungeonModel.instance:isElementFinish(var_30_0.elementMo.id) then
			gohelper.setActive(var_30_0.go, false)
			var_30_0.btnClick:RemoveClickListener()

			local var_30_1

			arg_30_0.subTaskItemMap[iter_30_0] = nil
		end
	end

	arg_30_0.subTaskShowEffectMap = arg_30_0:getUserDataTb_()
end

function var_0_0.refreshMapSelectUI(arg_31_0)
	local var_31_0 = OdysseyDungeonModel.instance:getMapInfoList()

	gohelper.setActive(arg_31_0._btnMapSelect.gameObject, #var_31_0 > 1)

	if HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.OdysseyDungeon) then
		recthelper.setAnchorX(arg_31_0._btnMapSelect.gameObject.transform, 0)
	else
		recthelper.setAnchorX(arg_31_0._btnMapSelect.gameObject.transform, -150)
	end
end

function var_0_0.setChangeMapUIState(arg_32_0, arg_32_1)
	gohelper.setActive(arg_32_0._gobottom, arg_32_1)
	gohelper.setActive(arg_32_0._goarrow, arg_32_1)
	gohelper.setActive(arg_32_0._btnMapSelect.gameObject, arg_32_1)
	gohelper.setActive(arg_32_0._goSubTaskItemContent, arg_32_1)
end

function var_0_0.showRightUI(arg_33_0, arg_33_1)
	gohelper.setActive(arg_33_0._goRight, arg_33_1)
	arg_33_0.levelComp:setShowState(arg_33_1)
end

function var_0_0.setInteractEleUIShowState(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.isMercenaryUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(arg_34_0.mercenaryUnlockCo.value)

	if arg_34_1 == OdysseyEnum.DungeonUISideType.Bottom then
		gohelper.setActive(arg_34_0._gobottom, arg_34_2)
		gohelper.setActive(arg_34_0._gomercenary, arg_34_2 and arg_34_0.isMercenaryUnlock)
	elseif arg_34_1 == OdysseyEnum.DungeonUISideType.Right then
		gohelper.setActive(arg_34_0._goRight, arg_34_2)
		gohelper.setActive(arg_34_0._gomercenary, arg_34_2 and arg_34_0.isMercenaryUnlock)
	end
end

function var_0_0.popupRewardView(arg_35_0)
	OdysseyDungeonController.instance:popupRewardView()
end

function var_0_0.showDungeonBagGetEffect(arg_36_0)
	gohelper.setActive(arg_36_0._gobackpackEffect, false)
	gohelper.setActive(arg_36_0._gobackpackEffect, true)
end

function var_0_0.showDungeonTalentGetEffect(arg_37_0)
	gohelper.setActive(arg_37_0._goherogroupEffect, false)
	gohelper.setActive(arg_37_0._goherogroupEffect, true)
end

function var_0_0.refreshReddot(arg_38_0)
	local var_38_0 = OdysseyMembersModel.instance:checkCanShowNewDot()

	gohelper.setActive(arg_38_0._goreligionReddot, var_38_0)

	local var_38_1 = OdysseyTalentModel.instance:checkHasNotUsedTalentPoint()

	gohelper.setActive(arg_38_0._goherogroupReddot, var_38_1)

	local var_38_2 = OdysseyDungeonModel.instance:checkHasNewUnlock(OdysseyEnum.LocalSaveKey.MythNew, OdysseyDungeonModel.instance:getCurUnlockMythIdList())

	gohelper.setActive(arg_38_0._gomythReddot, var_38_2)

	local var_38_3 = OdysseyItemModel.instance:checkIsItemNewFlag()

	gohelper.setActive(arg_38_0._gobackpackReddot, var_38_3)

	local var_38_4 = AssassinLibraryModel.instance:isAnyLibraryNewUnlock()

	gohelper.setActive(arg_38_0._godatabaseReddot, var_38_4)

	local var_38_5 = OdysseyDungeonModel.instance:checkHasNewUnlock(OdysseyEnum.LocalSaveKey.MapNew, OdysseyDungeonModel.instance:getCurUnlockMapIdList())

	gohelper.setActive(arg_38_0._goMapSelectReddot, var_38_5)
end

function var_0_0.refreshBottomBtnShow(arg_39_0)
	local var_39_0 = true
	local var_39_1 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.ReligionUnlock)
	local var_39_2 = OdysseyDungeonModel.instance:checkConditionCanUnlock(var_39_1.value)

	gohelper.setActive(arg_39_0._btnreligion.gameObject, var_39_2)

	local var_39_3 = #OdysseyItemModel.instance:getItemMoList() > 0

	gohelper.setActive(arg_39_0._btnbackpack.gameObject, var_39_3)

	local var_39_4 = OdysseyDungeonModel.instance:checkHasFightTypeElement(OdysseyEnum.FightType.Myth)

	gohelper.setActive(arg_39_0._btnmyth.gameObject, var_39_4)

	if not var_39_2 or not var_39_3 or not var_39_4 then
		var_39_0 = false
	end

	gohelper.setActive(arg_39_0._btnshowhide.gameObject, var_39_0)
end

function var_0_0.onUpdateElementPush(arg_40_0)
	arg_40_0:refreshMercenaryUI()
	arg_40_0:refreshBottomBtnShow()
	arg_40_0:refreshTaskUI()
	arg_40_0:createAndRefreshSubTaskItem()
	arg_40_0:playSubTaskItemShowEffect()
end

function var_0_0.showInteractCloseBtn(arg_41_0, arg_41_1)
	gohelper.setActive(arg_41_0._btnInteractClose.gameObject, arg_41_1)
end

function var_0_0.checkAndAutoExposeReligion(arg_42_0)
	local var_42_0 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.ReligionUnlock)

	if not OdysseyDungeonModel.instance:checkConditionCanUnlock(var_42_0.value) then
		return
	end

	local var_42_1 = OdysseyDungeonModel.instance:getCanAutoExposeReligionCoList()

	for iter_42_0, iter_42_1 in ipairs(var_42_1) do
		if OdysseyMembersModel.instance:checkReligionMemberCanExpose(iter_42_1.id) and not arg_42_0.hasExposeReligionMap[iter_42_1.id] then
			OdysseyRpc.instance:sendOdysseyFightReligionDiscloseRequest(iter_42_1.id)

			arg_42_0.hasExposeReligionMap[iter_42_1.id] = true
		end
	end
end

function var_0_0._onCloseViewFinish(arg_43_0, arg_43_1)
	if arg_43_1 == ViewName.OdysseyDungeonRewardView then
		gohelper.setActive(arg_43_0._gobackpackEffect, false)
		gohelper.setActive(arg_43_0._goherogroupEffect, false)
	end
end

function var_0_0.onClose(arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0.refreshMercenaryBar, arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0.cleanFinishSubTaskItem, arg_44_0)

	local var_44_0 = OdysseyDungeonModel.instance:getHeroInMapId()

	OdysseyDungeonModel.instance:setCurMapId(var_44_0)
	OdysseyDungeonModel.instance:setIsMapSelect(false)
	OdysseyDungeonModel.instance:setJumpNeedOpenElement(0)
	OdysseyDungeonModel.instance:setStoryOptionParam(nil)
	OdysseyDungeonModel.instance:setNeedFocusMainMapSelectItem(false)
	ViewMgr.instance:closeView(ViewName.OdysseyDungeonMapSelectInfoView)
	arg_44_0:_btnInteractCloseOnClick()
	AssassinController.instance:dispatchEvent(AssassinEvent.EnableLibraryToast, true)

	for iter_44_0, iter_44_1 in ipairs(arg_44_0.subTaskItemMap) do
		iter_44_1.btnClick:RemoveClickListener()
	end

	OdysseyStatHelper.instance:sendOdysseyViewStayTime("OdysseyDungeonView")
end

function var_0_0.onDestroyView(arg_45_0)
	return
end

return var_0_0
