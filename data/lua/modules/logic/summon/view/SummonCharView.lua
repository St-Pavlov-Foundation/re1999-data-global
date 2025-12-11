module("modules.logic.summon.view.SummonCharView", package.seeall)

local var_0_0 = class("SummonCharView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goresult = gohelper.findChild(arg_1_0.viewGO, "#go_result")
	arg_1_0._goresultitem = gohelper.findChild(arg_1_0.viewGO, "#go_result/resultcontent/#go_resultitem")
	arg_1_0._btnreturn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#btn_return")
	arg_1_0._btnopenall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#btn_openall")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "#go_drag")
	arg_1_0._goguide = gohelper.findChild(arg_1_0.viewGO, "#go_drag/#go_guide")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreturn:AddClickListener(arg_2_0._btnreturnOnClick, arg_2_0)
	arg_2_0._btnopenall:AddClickListener(arg_2_0._btnopenallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreturn:RemoveClickListener()
	arg_3_0._btnopenall:RemoveClickListener()
end

function var_0_0._btnreturnOnClick(arg_4_0)
	arg_4_0:_summonEnd()
end

function var_0_0.handleSkip(arg_5_0)
	logNormal("SummonCharView handleSkip")

	if not arg_5_0._isDrawing or not arg_5_0.summonResult then
		return
	end

	arg_5_0:_hideGuide()

	if arg_5_0:checkInitDrawComp() then
		arg_5_0._drawComp:skip()
	end

	local var_5_0 = {}

	if arg_5_0.summonResultCount == 10 then
		var_5_0 = SummonController.instance:getLimitedHeroSkinIdsByPopupParam()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonTurn)
	SummonController.instance:clearSummonPopupList()

	if not LoginController.instance:isEnteredGame() then
		return
	end

	local var_5_1 = SummonController.instance:getLastPoolId()

	if arg_5_0.summonResultCount == 1 then
		local var_5_2, var_5_3 = SummonModel.instance:openSummonResult(1)

		if var_5_2 then
			if var_5_2.heroId and var_5_2.heroId ~= 0 then
				SummonLuckyBagController.instance:skipOpenGetChar(var_5_2.heroId, var_5_3, var_5_1)
				SummonController.instance:nextSummonPopupParam()
			elseif var_5_2:isLuckyBag() then
				if not var_5_1 then
					return
				end

				SummonLuckyBagController.instance:skipOpenGetLuckyBag(var_5_2.luckyBagId, var_5_1)
			end
		end
	elseif arg_5_0.summonResultCount > 1 then
		for iter_5_0 = 1, 10 do
			SummonModel.instance:openSummonResult(iter_5_0)
		end

		if not var_5_1 then
			return
		end

		local var_5_4 = SummonConfig.instance:getSummonPool(var_5_1)

		if not var_5_4 then
			return
		end

		for iter_5_1, iter_5_2 in pairs(var_5_0) do
			SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, ViewName.LimitedRoleView, {
				limitedCO = lua_character_limited.configDict[iter_5_2],
				stopBgm = AudioBgmEnum.Layer.Summon
			})
		end

		local var_5_5 = SummonController.instance:getResultViewName()

		SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, var_5_5, {
			summonResultList = arg_5_0.summonResult,
			curPool = var_5_4
		})
		SummonController.instance:nextSummonPopupParam()
	end
end

function var_0_0._btnopenallOnClick(arg_6_0)
	arg_6_0._isOpeningAll = true

	for iter_6_0 = 1, 10 do
		arg_6_0:openSummonResult(iter_6_0, true)
	end

	SummonController.instance:nextSummonPopupParam()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0:checkInitDrawComp()

	arg_7_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_7_0._godrag)

	arg_7_0._drag:AddDragListener(arg_7_0.onDrag, arg_7_0)
	arg_7_0._drag:AddDragBeginListener(arg_7_0.onDragBegin, arg_7_0)
	arg_7_0._drag:AddDragEndListener(arg_7_0.onDragEnd, arg_7_0)

	arg_7_0._dragClickListener = SLFramework.UGUI.UIClickListener.Get(arg_7_0._godrag)

	arg_7_0._dragClickListener:AddClickDownListener(arg_7_0.onDragClickDown, arg_7_0)
	arg_7_0._dragClickListener:AddClickUpListener(arg_7_0.onDragClickUp, arg_7_0)
	gohelper.setActive(arg_7_0._goresultitem, false)

	arg_7_0._resultitems = {}
	arg_7_0._summonUIEffects = arg_7_0:getUserDataTb_()

	arg_7_0:_initTrackDragPos()
end

function var_0_0._initSummonView(arg_8_0)
	gohelper.setActive(arg_8_0._goresult, false)
	gohelper.setActive(arg_8_0._godrag, false)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:_initSummonView()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_10_0.startDraw, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimShowGuide, arg_10_0._showGuide, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimEnterDraw, arg_10_0.handleAnimStartDraw, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonDraw, arg_10_0.onDragComplete, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimRareEffect, arg_10_0.handleSummonAnimRareEffect, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, arg_10_0.onSummonAnimEnd, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonResultClose, arg_10_0._summonEnd, arg_10_0)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_10_0._onCloseView, arg_10_0)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_10_0._onOpenView, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonSkip, arg_10_0.handleSkip, arg_10_0)
	arg_10_0:_initSummonView()
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_11_0.startDraw, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimShowGuide, arg_11_0._showGuide, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonDraw, arg_11_0.onDragComplete, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimEnterDraw, arg_11_0.handleAnimStartDraw, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimRareEffect, arg_11_0.handleSummonAnimRareEffect, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, arg_11_0.onSummonAnimEnd, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonResultClose, arg_11_0._summonEnd, arg_11_0)
	arg_11_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_11_0._onCloseView, arg_11_0)
	arg_11_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_11_0._onOpenView, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonSkip, arg_11_0.handleSkip, arg_11_0)
	SummonModel.instance:setIsDrawing(false)
end

function var_0_0.onDragClickDown(arg_12_0)
	arg_12_0._lastDragAngle = nil
	arg_12_0._lastDragTime = nil

	if arg_12_0:checkInitDrawComp() then
		arg_12_0._drawComp:startTurn()
	end

	arg_12_0:_markTrackDragPos(true)
end

function var_0_0.onDragClickUp(arg_13_0)
	if arg_13_0:checkInitDrawComp() then
		arg_13_0._drawComp:endTurn()
	end

	arg_13_0:_updateDragArea()
end

function var_0_0.onDragBegin(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._lastDragAngle = nil
	arg_14_0._lastDragTime = nil

	if arg_14_0:checkInitDrawComp() then
		arg_14_0._drawComp:startTurn()
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_begin)
end

function var_0_0.onDragEnd(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0:checkInitDrawComp() then
		arg_15_0._drawComp:endTurn()
	end

	arg_15_0:_updateDragArea()
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_waterwheelstop)
end

var_0_0.TouchCenter = 0.1
var_0_0.TouchOuter = 3

function var_0_0.onDrag(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0._dragAreaInitialized or not arg_16_0:checkInitDrawComp() then
		return
	end

	local var_16_0 = recthelper.screenPosToAnchorPos(arg_16_2.position, arg_16_0._godrag.transform)
	local var_16_1 = var_16_0.x
	local var_16_2 = var_16_0.y
	local var_16_3 = arg_16_0._dragWidth
	local var_16_4 = arg_16_0._dragHeight
	local var_16_5 = var_0_0.TouchCenter
	local var_16_6 = var_0_0.TouchOuter

	if var_16_1 * var_16_1 + var_16_2 * var_16_2 < (var_16_3 + var_16_4) * (var_16_3 + var_16_4) / 16 * var_16_5 * var_16_5 then
		arg_16_0._lastDragAngle = nil

		return
	end

	if var_16_1 * var_16_1 + var_16_2 * var_16_2 > (var_16_3 + var_16_4) * (var_16_3 + var_16_4) / 16 * var_16_6 * var_16_6 then
		arg_16_0._lastDragAngle = nil

		return
	end

	local var_16_7 = 0
	local var_16_8 = 1e-06

	if math.abs(var_16_1) < var_16_3 * var_16_8 then
		var_16_7 = var_16_2 > 0 and 90 or 270
	elseif math.abs(var_16_2) < var_16_4 * var_16_8 then
		var_16_7 = var_16_1 > 0 and 0 or 180
	else
		var_16_7 = math.deg(math.atan(var_16_2 / var_16_1)) + (var_16_1 * var_16_2 > 0 and 0 or 180) + (var_16_2 > 0 and 0 or 180)
	end

	local var_16_9 = Time.unscaledTime

	if arg_16_0._lastDragAngle and arg_16_0._lastDragTime then
		local var_16_10 = var_16_7 - arg_16_0._lastDragAngle

		if arg_16_0._lastDragAngle > 270 and var_16_7 < 90 then
			var_16_10 = 360 - arg_16_0._lastDragAngle + var_16_7
		end

		if arg_16_0._lastDragAngle < 90 and var_16_7 > 270 then
			var_16_10 = -360 - arg_16_0._lastDragAngle + var_16_7
		end

		arg_16_0._drawComp:updateAngle(var_16_10)
	end

	arg_16_0._lastDragAngle = var_16_7
	arg_16_0._lastDragTime = var_16_9

	arg_16_0:_hideGuide()
	TaskDispatcher.runDelay(arg_16_0._showGuide, arg_16_0, 3)
	arg_16_0:_updateDragArea()
end

function var_0_0.onDragComplete(arg_17_0)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonTurn)
	arg_17_0:_summonStart()
	arg_17_0:_hideGuide()
	arg_17_0:_markTrackDragPos(false, true)
end

function var_0_0._showGuide(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._showGuide, arg_18_0)
	gohelper.setActive(arg_18_0._goguide, true)
end

function var_0_0._hideGuide(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._showGuide, arg_19_0)
	gohelper.setActive(arg_19_0._goguide, false)
end

function var_0_0.startDraw(arg_20_0)
	if not arg_20_0:checkInitDrawComp() then
		arg_20_0:handleSkip()

		return
	end

	SummonController.instance:clearSummonPopupList()

	arg_20_0._isOpeningAll = false

	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonAward))

	arg_20_0.resultViewIsClose = false
	arg_20_0.summonResult = SummonModel.instance:getSummonResult(true)
	arg_20_0.summonResultCount = tabletool.len(arg_20_0.summonResult)

	if arg_20_0.summonResultCount then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_callfor_ten)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_callfor_once)
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_inscription_amb)
	gohelper.setActive(arg_20_0._goresult, false)
	SummonController.instance:resetAnim()
	arg_20_0:recycleEffect()

	if arg_20_0.summonResult and arg_20_0.summonResultCount > 0 then
		arg_20_0._isDrawing = true

		SummonModel.instance:setIsDrawing(true)

		local var_20_0 = SummonModel.getBestRare(arg_20_0.summonResult)

		arg_20_0._drawComp:resetDraw(var_20_0, arg_20_0.summonResultCount > 1)

		if not SummonController.instance:getIsGuideAnim() and not SummonController.instance:isInSummonGuide() then
			SummonController.instance:startPlayAnim()
		else
			arg_20_0:handleAnimStartDraw()
		end
	end
end

function var_0_0.checkInitDrawComp(arg_21_0)
	if arg_21_0._drawComp == nil then
		arg_21_0._drawComp = VirtualSummonScene.instance:getSummonScene().director:getDrawComp(SummonEnum.ResultType.Char)
	end

	return arg_21_0._drawComp ~= nil
end

function var_0_0.handleAnimStartDraw(arg_22_0)
	gohelper.setActive(arg_22_0._godrag.gameObject, true)
	SummonController.instance:forbidAnim()

	local var_22_0 = SummonModel.getBestRare(arg_22_0.summonResult)

	arg_22_0:_initDragArea(var_22_0)
	arg_22_0:_showGuide()
end

function var_0_0._initDragArea(arg_23_0, arg_23_1)
	arg_23_0:_updateDragArea()

	arg_23_0._dragAreaInitialized = true
end

function var_0_0._updateDragArea(arg_24_0)
	local var_24_0 = 220
	local var_24_1 = 400
	local var_24_2 = SummonController.instance:getSceneNode("anim/StandStill/Obj-Plant/s06_Obj_d/top_left")
	local var_24_3 = SummonController.instance:getSceneNode("anim/StandStill/Obj-Plant/s06_Obj_d/bottom_right")
	local var_24_4 = recthelper.worldPosToAnchorPos(var_24_2.transform.position, arg_24_0.viewGO.transform)
	local var_24_5 = recthelper.worldPosToAnchorPos(var_24_3.transform.position, arg_24_0.viewGO.transform)

	arg_24_0._dragPosX = (var_24_4.x + var_24_5.x) / 2
	arg_24_0._dragPosY = (var_24_4.y + var_24_5.y) / 2

	recthelper.setAnchor(arg_24_0._godrag.transform, arg_24_0._dragPosX, arg_24_0._dragPosY)

	arg_24_0._dragHeight = math.abs(var_24_4.y - var_24_5.y) + var_24_1

	recthelper.setHeight(arg_24_0._godrag.transform, arg_24_0._dragHeight)

	arg_24_0._dragWidth = math.abs(var_24_5.x - var_24_4.x) + var_24_0

	recthelper.setWidth(arg_24_0._godrag.transform, arg_24_0._dragWidth)

	arg_24_0._dragHeight = math.abs(var_24_4.y - var_24_5.y)
	arg_24_0._dragWidth = math.abs(var_24_5.x - var_24_4.x)
end

function var_0_0._summonStart(arg_25_0)
	gohelper.setActive(arg_25_0._godrag.gameObject, false)

	local var_25_0 = SummonModel.getBestRare(arg_25_0.summonResult)

	if arg_25_0.summonResultCount > 1 then
		SummonController.instance:drawAnim()
		AudioMgr.instance:trigger(AudioEnum.Summon.Play_Summon_TenTimes)
	else
		SummonController.instance:drawOnlyAnim()
		AudioMgr.instance:trigger(AudioEnum.Summon.Play_Summon_Once)
	end

	local var_25_1 = AudioEnum.SummonSwitchState[var_25_0 - 1]

	if not string.nilorempty(var_25_1) then
		AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.SummonResult), AudioMgr.instance:getIdFromString(var_25_1))
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_chestsopen)
	arg_25_0:_boomAttachEffect()
end

function var_0_0._boomAttachEffect(arg_26_0)
	if not arg_26_0:checkInitDrawComp() then
		arg_26_0:handleSkip()
	end

	local var_26_0 = SummonModel.getBestRare(arg_26_0.summonResult)
	local var_26_1 = SummonEnum.SummonQualityDefine[var_26_0]

	if string.nilorempty(var_26_1) then
		return
	end

	local var_26_2 = string.format("Scene%sBoom", var_26_1)
	local var_26_3 = SummonEnum.SummonPreloadPath[var_26_2]

	if var_26_3 then
		local var_26_4 = arg_26_0._drawComp:getStepEffectContainer()

		arg_26_0._sceneBoomEffectWrap = SummonEffectPool.getEffect(var_26_3, var_26_4)

		if arg_26_0._sceneBoomEffectWrap then
			arg_26_0._sceneBoomEffectWrap:play()

			return
		end
	end
end

function var_0_0.handleSummonAnimRareEffect(arg_27_0)
	local var_27_0 = {}

	if arg_27_0.summonResultCount > 1 then
		var_27_0 = SummonController.instance:getUINodes()
	else
		var_27_0 = SummonController.instance:getOnlyUINode()
	end

	local var_27_1 = false

	for iter_27_0, iter_27_1 in pairs(arg_27_0.summonResult) do
		if iter_27_1:isLuckyBag() then
			arg_27_0:createResultLuckyBagEffect(iter_27_1, var_27_0, iter_27_0)

			var_27_1 = true
		else
			arg_27_0:createResultCharRareEffect(iter_27_1, var_27_0, iter_27_0)
		end
	end

	if var_27_1 then
		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_wulu_lucky_bag_prize)
	end
end

function var_0_0.createResultCharRareEffect(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = HeroConfig.instance:getHeroCO(arg_28_1.heroId)
	local var_28_1 = ""
	local var_28_2 = ""

	if var_28_0.rare <= 2 then
		var_28_1 = SummonEnum.SummonPreloadPath.UIN
	elseif var_28_0.rare == 3 then
		var_28_1 = SummonEnum.SummonPreloadPath.UIR
	elseif var_28_0.rare == 4 then
		var_28_1 = SummonEnum.SummonPreloadPath.UISR
	else
		var_28_1 = SummonEnum.SummonPreloadPath.UISSR
	end

	local var_28_3 = SummonEnum.AnimationName[var_28_1]
	local var_28_4 = SummonEffectPool.getEffect(var_28_1, arg_28_2[arg_28_3])

	var_28_4:setAnimationName(var_28_3)
	var_28_4:play()
	table.insert(arg_28_0._summonUIEffects, var_28_4)
end

function var_0_0.createResultLuckyBagEffect(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = SummonEnum.SummonLuckyBagPreloadPath.UILuckyBag
	local var_29_1 = ""
	local var_29_2 = arg_29_1.luckyBagId
	local var_29_3 = SummonController.instance:getLastPoolId()

	if not var_29_3 then
		return
	end

	local var_29_4 = SummonConfig.instance:getLuckyBag(var_29_3, var_29_2)

	if not var_29_4 then
		return
	end

	local var_29_5 = SummonEnum.AnimationName[var_29_0]
	local var_29_6 = SummonEffectPool.getEffect(var_29_0, arg_29_2[arg_29_3])

	var_29_6:loadHeadTex(ResUrl.getSummonSceneTexture(var_29_4.sceneIcon))
	var_29_6:setAnimationName(var_29_5)
	var_29_6:play()
	table.insert(arg_29_0._summonUIEffects, var_29_6)
end

function var_0_0.onSummonAnimEnd(arg_30_0)
	gohelper.setActive(arg_30_0._goresult, true)
	gohelper.setActive(arg_30_0._btnreturn.gameObject, false)
	gohelper.setActive(arg_30_0._btnopenall.gameObject, arg_30_0.summonResultCount > 1)
	arg_30_0:initSummonResult()
end

function var_0_0.initSummonResult(arg_31_0)
	arg_31_0._waitEffectList = {}
	arg_31_0._waitNormalEffectList = {}
	arg_31_0._luckyBagIdList = {}

	local var_31_0 = {}

	if arg_31_0.summonResultCount > 1 then
		var_31_0 = SummonController.instance:getUINodes()
	else
		var_31_0 = SummonController.instance:getOnlyUINode()
	end

	local var_31_1 = {}

	for iter_31_0, iter_31_1 in pairs(arg_31_0.summonResult) do
		local var_31_2 = arg_31_0._resultitems[iter_31_0]

		if not var_31_2 then
			var_31_2 = arg_31_0:getUserDataTb_()
			var_31_2.go = gohelper.cloneInPlace(arg_31_0._goresultitem, "item" .. iter_31_0)
			var_31_2.index = iter_31_0
			var_31_2.btnopen = gohelper.findChildButtonWithAudio(var_31_2.go, "btn_open")

			var_31_2.btnopen:AddClickListener(function(arg_32_0)
				arg_31_0:openSummonResult(arg_32_0.index)
				SummonController.instance:nextSummonPopupParam()
			end, var_31_2)

			arg_31_0._resultitems[iter_31_0] = var_31_2
		end

		local var_31_3 = var_31_0[iter_31_0]

		if var_31_3 then
			local var_31_4 = gohelper.findChild(var_31_3, "btn/btnTopLeft")
			local var_31_5 = gohelper.findChild(var_31_3, "btn/btnBottomRight")
			local var_31_6 = recthelper.worldPosToAnchorPos(var_31_4.transform.position, arg_31_0.viewGO.transform)
			local var_31_7 = recthelper.worldPosToAnchorPos(var_31_5.transform.position, arg_31_0.viewGO.transform)

			recthelper.setAnchor(var_31_2.go.transform, (var_31_6.x + var_31_7.x) / 2, (var_31_6.y + var_31_7.y) / 2)
			recthelper.setHeight(var_31_2.go.transform, math.abs(var_31_6.y - var_31_7.y))
			recthelper.setWidth(var_31_2.go.transform, math.abs(var_31_7.x - var_31_6.x))
		end

		gohelper.setActive(var_31_2.btnopen.gameObject, true)
		gohelper.setActive(var_31_2.go, true)

		var_31_1[iter_31_0] = true
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0._resultitems) do
		if not var_31_1[iter_31_2] then
			gohelper.setActive(iter_31_3.go, false)
		end
	end
end

function var_0_0.openSummonResult(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0, var_33_1 = SummonModel.instance:openSummonResult(arg_33_1)
	local var_33_2 = SummonModel.instance:getSummonResult(false)
	local var_33_3 = #var_33_2 > 1

	if var_33_0 then
		local var_33_4 = var_33_0.heroId
		local var_33_5

		if var_33_4 ~= nil and var_33_4 ~= 0 then
			var_33_5 = HeroConfig.instance:getHeroCO(var_33_4)
		end

		if not arg_33_2 and var_33_4 ~= 0 then
			logNormal(string.format("获得角色:%s", var_33_5.name))
		end

		if arg_33_0._resultitems[arg_33_1] then
			gohelper.setActive(arg_33_0._resultitems[arg_33_1].btnopen.gameObject, false)
		end

		if not var_33_3 or not arg_33_2 or var_33_1 <= 0 or var_33_5 and var_33_5.rare >= 5 then
			if not var_33_0:isLuckyBag() then
				table.insert(arg_33_0._waitEffectList, {
					index = arg_33_1,
					heroId = var_33_4,
					luckyBagId = var_33_0.luckyBagId
				})
				arg_33_0:insertSingleCharPopup(var_33_4, var_33_1, var_33_3)
			else
				local var_33_6 = {
					var_33_0.luckyBagId
				}

				arg_33_0:insertLuckyBagPopup(var_33_6)
			end
		elseif not arg_33_2 then
			arg_33_0._summonUIEffects[arg_33_1]:loadHeroIcon(var_33_4)
		else
			table.insert(arg_33_0._waitNormalEffectList, {
				index = arg_33_1,
				heroId = var_33_4,
				luckyBagId = var_33_0.luckyBagId
			})
		end

		if SummonModel.instance:isAllOpened() then
			gohelper.setActive(arg_33_0._btnopenall.gameObject, false)

			if not var_33_3 then
				gohelper.setActive(arg_33_0._btnreturn.gameObject, true)
			else
				local var_33_7 = SummonController.instance:getLastPoolId()

				if not var_33_7 then
					return
				end

				local var_33_8 = SummonConfig.instance:getSummonPool(var_33_7)

				if not var_33_8 then
					return
				end

				local var_33_9 = SummonController.instance:getResultViewName()

				SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, var_33_9, {
					summonResultList = var_33_2,
					curPool = var_33_8
				})
			end
		end
	end
end

function var_0_0.insertSingleCharPopup(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = SummonController.instance:getLastPoolId()

	if not var_34_0 then
		return
	end

	local var_34_1 = SummonConfig.instance:getSummonPool(var_34_0)

	if not var_34_1 then
		return
	end

	local var_34_2

	if var_34_1.ticketId ~= 0 then
		var_34_2 = var_34_1.ticketId
	end

	local var_34_3 = {
		isSummon = true,
		heroId = arg_34_1,
		duplicateCount = arg_34_2,
		isSummonTen = arg_34_3,
		summonTicketId = var_34_2
	}
	local var_34_4 = SummonController.instance:getMvSkinIdByHeroId(arg_34_1)

	if var_34_4 then
		var_34_3.skipVideo = true
		var_34_3.mvSkinId = var_34_4
	end

	SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, var_34_3)
end

function var_0_0.insertLuckyBagPopup(arg_35_0, arg_35_1)
	local var_35_0 = SummonController.instance:getLastPoolId()

	if not var_35_0 then
		return
	end

	local var_35_1 = {
		luckyBagIdList = arg_35_1,
		poolId = var_35_0
	}

	SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.GainCharacterView, ViewName.SummonGetLuckyBag, var_35_1)
end

function var_0_0._refreshIcons(arg_36_0)
	if (not arg_36_0._waitEffectList or #arg_36_0._waitEffectList <= 1) and arg_36_0._waitNormalEffectList and #arg_36_0._waitNormalEffectList > 0 then
		for iter_36_0, iter_36_1 in ipairs(arg_36_0._waitNormalEffectList) do
			local var_36_0 = iter_36_1.index
			local var_36_1 = iter_36_1.heroId
			local var_36_2 = arg_36_0._summonUIEffects[var_36_0]

			if var_36_2 and var_36_1 ~= 0 then
				var_36_2:loadHeroIcon(var_36_1)
			end
		end
	end

	if not arg_36_0._waitEffectList or #arg_36_0._waitEffectList <= 0 then
		return
	end

	local var_36_3 = arg_36_0._waitEffectList[1]

	table.remove(arg_36_0._waitEffectList, 1)

	local var_36_4 = var_36_3.index
	local var_36_5 = var_36_3.heroId
	local var_36_6 = arg_36_0._summonUIEffects[var_36_4]

	if not var_36_6 or var_36_5 == 0 then
		return
	end

	var_36_6:loadHeroIcon(var_36_5)
end

function var_0_0._summonEnd(arg_37_0)
	if not arg_37_0._isDrawing then
		return
	end

	arg_37_0._isDrawing = false

	SummonModel.instance:setIsDrawing(false)
	SummonController.instance:clearSummonPopupList()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonNormal))
	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	gohelper.setActive(arg_37_0._gosummon, true)
	gohelper.setActive(arg_37_0._goresult, false)
	arg_37_0:recycleEffect()

	if arg_37_0._sceneBoomEffectWrap then
		SummonEffectPool.returnEffect(arg_37_0._sceneBoomEffectWrap)

		arg_37_0._sceneBoomEffectWrap = nil
	end

	SummonController.instance:resetAnim()

	if not LoginController.instance:isEnteredGame() then
		return
	end

	SummonMainModel.instance:updateLastPoolId()

	local var_37_0 = {
		jumpPoolId = SummonController.instance:getLastPoolId()
	}
	local var_37_1 = SummonController.instance:getSummonEndOpenCallBack()

	if var_37_1 then
		var_37_1:invoke()
		SummonController.instance:setSummonEndOpenCallBack(nil, nil)
	else
		SummonMainController.instance:openSummonView(var_37_0)
	end

	arg_37_0:_gc()

	arg_37_0.summonResult = {}
	arg_37_0.summonResultCount = 0
end

function var_0_0._onCloseView(arg_38_0, arg_38_1)
	if arg_38_1 == ViewName.SummonResultView or arg_38_1 == ViewName.SummonSimulationResultView then
		arg_38_0.resultViewIsClose = true
	end

	if arg_38_1 == ViewName.CharacterGetView or arg_38_1 == ViewName.SummonGetLuckyBag or arg_38_1 == ViewName.LimitedRoleView then
		arg_38_0:_refreshIcons()

		if arg_38_0.summonResult then
			if arg_38_0.summonResultCount == 1 and arg_38_1 ~= ViewName.LimitedRoleView then
				arg_38_0:_summonEnd()
			else
				SummonController.instance:nextSummonPopupParam()
			end
		end
	elseif arg_38_1 == ViewName.CommonPropView and arg_38_0.summonResult and arg_38_0.summonResultCount > 1 and arg_38_0.resultViewIsClose then
		arg_38_0:_summonEnd()
	end
end

function var_0_0._onOpenView(arg_39_0, arg_39_1)
	if arg_39_1 == SummonController.instance:getResultViewName() then
		arg_39_0:_refreshIcons()
	end
end

function var_0_0.recycleEffect(arg_40_0)
	if arg_40_0._summonUIEffects then
		for iter_40_0 = 1, #arg_40_0._summonUIEffects do
			local var_40_0 = arg_40_0._summonUIEffects[iter_40_0]

			SummonEffectPool.returnEffect(var_40_0)

			arg_40_0._summonUIEffects[iter_40_0] = nil
		end
	end
end

function var_0_0.onDestroyView(arg_41_0)
	for iter_41_0, iter_41_1 in pairs(arg_41_0._resultitems) do
		iter_41_1.btnopen:RemoveClickListener()
	end

	arg_41_0._drag:RemoveDragListener()
	arg_41_0._drag:RemoveDragBeginListener()
	arg_41_0._drag:RemoveDragEndListener()
	arg_41_0._dragClickListener:RemoveClickDownListener()
	arg_41_0._dragClickListener:RemoveClickUpListener()
end

function var_0_0._gc(arg_42_0)
	arg_42_0._summonCount = (arg_42_0._summonCount or 0) + (arg_42_0.summonResult and arg_42_0.summonResultCount)

	if arg_42_0._summonCount > 1 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, arg_42_0)

		arg_42_0._summonCount = 0
	end
end

function var_0_0._initTrackDragPos(arg_43_0)
	local var_43_0, var_43_1 = recthelper.getAnchor(arg_43_0._godrag.transform)

	arg_43_0._sdkTrackDragPosInfo = {
		st = {
			x = var_43_0,
			y = var_43_1
		},
		ed = {
			x = var_43_0,
			y = var_43_1
		}
	}
end

function var_0_0._markTrackDragPos(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_1 then
		arg_44_0._sdkTrackDragPosInfo.st.x = arg_44_0._dragPosX
		arg_44_0._sdkTrackDragPosInfo.st.y = arg_44_0._dragPosY
	else
		arg_44_0._sdkTrackDragPosInfo.ed.x = arg_44_0._dragPosX
		arg_44_0._sdkTrackDragPosInfo.ed.y = arg_44_0._dragPosY
	end

	if arg_44_2 then
		SummonController.instance:trackSummonClientEvent(false, arg_44_0._sdkTrackDragPosInfo)
	end
end

return var_0_0
