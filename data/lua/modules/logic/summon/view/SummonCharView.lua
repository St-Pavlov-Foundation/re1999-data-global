module("modules.logic.summon.view.SummonCharView", package.seeall)

slot0 = class("SummonCharView", BaseView)

function slot0.onInitView(slot0)
	slot0._goresult = gohelper.findChild(slot0.viewGO, "#go_result")
	slot0._goresultitem = gohelper.findChild(slot0.viewGO, "#go_result/resultcontent/#go_resultitem")
	slot0._btnreturn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#btn_return")
	slot0._btnopenall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#btn_openall")
	slot0._godrag = gohelper.findChild(slot0.viewGO, "#go_drag")
	slot0._goguide = gohelper.findChild(slot0.viewGO, "#go_drag/#go_guide")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreturn:AddClickListener(slot0._btnreturnOnClick, slot0)
	slot0._btnopenall:AddClickListener(slot0._btnopenallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreturn:RemoveClickListener()
	slot0._btnopenall:RemoveClickListener()
end

function slot0._btnreturnOnClick(slot0)
	slot0:_summonEnd()
end

function slot0.handleSkip(slot0)
	logNormal("SummonCharView handleSkip")

	if not slot0._isDrawing or not slot0.summonResult then
		return
	end

	slot0:_hideGuide()

	if slot0:checkInitDrawComp() then
		slot0._drawComp:skip()
	end

	slot1 = {}

	if slot0.summonResultCount == 10 then
		slot1 = SummonController.instance:getLimitedHeroSkinIdsByPopupParam()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonTurn)
	SummonController.instance:clearSummonPopupList()

	if not LoginController.instance:isEnteredGame() then
		return
	end

	if slot0.summonResultCount == 1 then
		slot3, slot4 = SummonModel.instance:openSummonResult(1)

		if slot3 then
			if slot3.heroId and slot3.heroId ~= 0 then
				SummonLuckyBagController.instance:skipOpenGetChar(slot3.heroId, slot4, SummonController.instance:getLastPoolId())
				SummonController.instance:nextSummonPopupParam()
			elseif slot3:isLuckyBag() then
				if not slot2 then
					return
				end

				SummonLuckyBagController.instance:skipOpenGetLuckyBag(slot3.luckyBagId, slot2)
			end
		end
	elseif slot0.summonResultCount > 1 then
		for slot6 = 1, 10 do
			SummonModel.instance:openSummonResult(slot6)
		end

		if not slot2 then
			return
		end

		if not SummonConfig.instance:getSummonPool(slot2) then
			return
		end

		for slot7, slot8 in pairs(slot1) do
			SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, ViewName.LimitedRoleView, {
				limitedCO = lua_character_limited.configDict[slot8],
				stopBgm = AudioBgmEnum.Layer.Summon
			})
		end

		SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, SummonController.instance:getResultViewName(), {
			summonResultList = slot0.summonResult,
			curPool = slot3
		})
		SummonController.instance:nextSummonPopupParam()
	end
end

function slot0._btnopenallOnClick(slot0)
	slot0._isOpeningAll = true

	for slot4 = 1, 10 do
		slot0:openSummonResult(slot4, true)
	end

	SummonController.instance:nextSummonPopupParam()
end

function slot0._editableInitView(slot0)
	slot0:checkInitDrawComp()

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godrag)

	slot0._drag:AddDragListener(slot0.onDrag, slot0)
	slot0._drag:AddDragBeginListener(slot0.onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0.onDragEnd, slot0)

	slot0._dragClickListener = SLFramework.UGUI.UIClickListener.Get(slot0._godrag)

	slot0._dragClickListener:AddClickDownListener(slot0.onDragClickDown, slot0)
	slot0._dragClickListener:AddClickUpListener(slot0.onDragClickUp, slot0)
	gohelper.setActive(slot0._goresultitem, false)

	slot0._resultitems = {}
	slot0._summonUIEffects = slot0:getUserDataTb_()

	slot0:_initTrackDragPos()
end

function slot0._initSummonView(slot0)
	gohelper.setActive(slot0._goresult, false)
	gohelper.setActive(slot0._godrag, false)
end

function slot0.onUpdateParam(slot0)
	slot0:_initSummonView()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.startDraw, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimShowGuide, slot0._showGuide, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimEnterDraw, slot0.handleAnimStartDraw, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonDraw, slot0.onDragComplete, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimRareEffect, slot0.handleSummonAnimRareEffect, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, slot0.onSummonAnimEnd, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonResultClose, slot0._summonEnd, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonSkip, slot0.handleSkip, slot0)
	slot0:_initSummonView()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.startDraw, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimShowGuide, slot0._showGuide, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonDraw, slot0.onDragComplete, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimEnterDraw, slot0.handleAnimStartDraw, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimRareEffect, slot0.handleSummonAnimRareEffect, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, slot0.onSummonAnimEnd, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonResultClose, slot0._summonEnd, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonSkip, slot0.handleSkip, slot0)
	SummonModel.instance:setIsDrawing(false)
end

function slot0.onDragClickDown(slot0)
	slot0._lastDragAngle = nil
	slot0._lastDragTime = nil

	if slot0:checkInitDrawComp() then
		slot0._drawComp:startTurn()
	end

	slot0:_markTrackDragPos(true)
end

function slot0.onDragClickUp(slot0)
	if slot0:checkInitDrawComp() then
		slot0._drawComp:endTurn()
	end

	slot0:_updateDragArea()
end

function slot0.onDragBegin(slot0, slot1, slot2)
	slot0._lastDragAngle = nil
	slot0._lastDragTime = nil

	if slot0:checkInitDrawComp() then
		slot0._drawComp:startTurn()
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_begin)
end

function slot0.onDragEnd(slot0, slot1, slot2)
	if slot0:checkInitDrawComp() then
		slot0._drawComp:endTurn()
	end

	slot0:_updateDragArea()
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_waterwheelstop)
end

slot0.TouchCenter = 0.1
slot0.TouchOuter = 3

function slot0.onDrag(slot0, slot1, slot2)
	if not slot0._dragAreaInitialized or not slot0:checkInitDrawComp() then
		return
	end

	slot3 = recthelper.screenPosToAnchorPos(slot2.position, slot0._godrag.transform)
	slot4 = slot3.x
	slot5 = slot3.y
	slot6 = slot0._dragWidth
	slot7 = slot0._dragHeight
	slot8 = uv0.TouchCenter
	slot9 = uv0.TouchOuter

	if slot4 * slot4 + slot5 * slot5 < (slot6 + slot7) * (slot6 + slot7) / 16 * slot8 * slot8 then
		slot0._lastDragAngle = nil

		return
	end

	if slot4 * slot4 + slot5 * slot5 > (slot6 + slot7) * (slot6 + slot7) / 16 * slot9 * slot9 then
		slot0._lastDragAngle = nil

		return
	end

	slot10 = 0
	slot10 = math.abs(slot4) < slot6 * 1e-06 and (slot5 > 0 and 90 or 270) or math.abs(slot5) < slot7 * slot11 and (slot4 > 0 and 0 or 180) or math.deg(math.atan(slot5 / slot4)) + (slot4 * slot5 > 0 and 0 or 180) + (slot5 > 0 and 0 or 180)
	slot12 = Time.unscaledTime

	if slot0._lastDragAngle and slot0._lastDragTime then
		slot13 = slot10 - slot0._lastDragAngle

		if slot0._lastDragAngle > 270 and slot10 < 90 then
			slot13 = 360 - slot0._lastDragAngle + slot10
		end

		if slot0._lastDragAngle < 90 and slot10 > 270 then
			slot13 = -360 - slot0._lastDragAngle + slot10
		end

		slot0._drawComp:updateAngle(slot13)
	end

	slot0._lastDragAngle = slot10
	slot0._lastDragTime = slot12

	slot0:_hideGuide()
	TaskDispatcher.runDelay(slot0._showGuide, slot0, 3)
	slot0:_updateDragArea()
end

function slot0.onDragComplete(slot0)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonTurn)
	slot0:_summonStart()
	slot0:_hideGuide()
	slot0:_markTrackDragPos(false, true)
end

function slot0._showGuide(slot0)
	TaskDispatcher.cancelTask(slot0._showGuide, slot0)
	gohelper.setActive(slot0._goguide, true)
end

function slot0._hideGuide(slot0)
	TaskDispatcher.cancelTask(slot0._showGuide, slot0)
	gohelper.setActive(slot0._goguide, false)
end

function slot0.startDraw(slot0)
	if not slot0:checkInitDrawComp() then
		slot0:handleSkip()

		return
	end

	SummonController.instance:clearSummonPopupList()

	slot0._isOpeningAll = false

	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonAward))

	slot0.summonResult = SummonModel.instance:getSummonResult(true)
	slot0.summonResultCount = tabletool.len(slot0.summonResult)

	if slot0.summonResultCount then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_callfor_ten)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_callfor_once)
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_inscription_amb)
	gohelper.setActive(slot0._goresult, false)
	SummonController.instance:resetAnim()
	slot0:recycleEffect()

	if slot0.summonResult and slot0.summonResultCount > 0 then
		slot0._isDrawing = true

		SummonModel.instance:setIsDrawing(true)
		slot0._drawComp:resetDraw(SummonModel.getBestRare(slot0.summonResult), slot0.summonResultCount > 1)

		if not SummonController.instance:getIsGuideAnim() and not SummonController.instance:isInSummonGuide() then
			SummonController.instance:startPlayAnim()
		else
			slot0:handleAnimStartDraw()
		end
	end
end

function slot0.checkInitDrawComp(slot0)
	if slot0._drawComp == nil then
		slot0._drawComp = VirtualSummonScene.instance:getSummonScene().director:getDrawComp(SummonEnum.ResultType.Char)
	end

	return slot0._drawComp ~= nil
end

function slot0.handleAnimStartDraw(slot0)
	gohelper.setActive(slot0._godrag.gameObject, true)
	SummonController.instance:forbidAnim()
	slot0:_initDragArea(SummonModel.getBestRare(slot0.summonResult))
	slot0:_showGuide()
end

function slot0._initDragArea(slot0, slot1)
	slot0:_updateDragArea()

	slot0._dragAreaInitialized = true
end

function slot0._updateDragArea(slot0)
	slot5 = recthelper.worldPosToAnchorPos(SummonController.instance:getSceneNode("anim/StandStill/Obj-Plant/s06_Obj_d/top_left").transform.position, slot0.viewGO.transform)
	slot6 = recthelper.worldPosToAnchorPos(SummonController.instance:getSceneNode("anim/StandStill/Obj-Plant/s06_Obj_d/bottom_right").transform.position, slot0.viewGO.transform)
	slot0._dragPosX = (slot5.x + slot6.x) / 2
	slot0._dragPosY = (slot5.y + slot6.y) / 2

	recthelper.setAnchor(slot0._godrag.transform, slot0._dragPosX, slot0._dragPosY)

	slot0._dragHeight = math.abs(slot5.y - slot6.y) + 400

	recthelper.setHeight(slot0._godrag.transform, slot0._dragHeight)

	slot0._dragWidth = math.abs(slot6.x - slot5.x) + 220

	recthelper.setWidth(slot0._godrag.transform, slot0._dragWidth)

	slot0._dragHeight = math.abs(slot5.y - slot6.y)
	slot0._dragWidth = math.abs(slot6.x - slot5.x)
end

function slot0._summonStart(slot0)
	gohelper.setActive(slot0._godrag.gameObject, false)

	slot1 = SummonModel.getBestRare(slot0.summonResult)

	if slot0.summonResultCount > 1 then
		SummonController.instance:drawAnim()
		AudioMgr.instance:trigger(AudioEnum.Summon.Play_Summon_TenTimes)
	else
		SummonController.instance:drawOnlyAnim()
		AudioMgr.instance:trigger(AudioEnum.Summon.Play_Summon_Once)
	end

	if not string.nilorempty(AudioEnum.SummonSwitchState[slot1 - 1]) then
		AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.SummonResult), AudioMgr.instance:getIdFromString(slot2))
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_chestsopen)
	slot0:_boomAttachEffect()
end

function slot0._boomAttachEffect(slot0)
	if not slot0:checkInitDrawComp() then
		slot0:handleSkip()
	end

	if string.nilorempty(SummonEnum.SummonQualityDefine[SummonModel.getBestRare(slot0.summonResult)]) then
		return
	end

	if SummonEnum.SummonPreloadPath[string.format("Scene%sBoom", slot2)] then
		slot0._sceneBoomEffectWrap = SummonEffectPool.getEffect(slot4, slot0._drawComp:getStepEffectContainer())

		if slot0._sceneBoomEffectWrap then
			slot0._sceneBoomEffectWrap:play()

			return
		end
	end
end

function slot0.handleSummonAnimRareEffect(slot0)
	slot1 = {}
	slot2 = false

	for slot6, slot7 in pairs(slot0.summonResult) do
		if slot7:isLuckyBag() then
			slot0:createResultLuckyBagEffect(slot7, (slot0.summonResultCount <= 1 or SummonController.instance:getUINodes()) and SummonController.instance:getOnlyUINode(), slot6)

			slot2 = true
		else
			slot0:createResultCharRareEffect(slot7, slot1, slot6)
		end
	end

	if slot2 then
		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_wulu_lucky_bag_prize)
	end
end

function slot0.createResultCharRareEffect(slot0, slot1, slot2, slot3)
	slot5 = ""
	slot6 = ""
	slot5 = (HeroConfig.instance:getHeroCO(slot1.heroId).rare > 2 or SummonEnum.SummonPreloadPath.UIN) and (slot4.rare ~= 3 or SummonEnum.SummonPreloadPath.UIR) and (slot4.rare ~= 4 or SummonEnum.SummonPreloadPath.UISR) and SummonEnum.SummonPreloadPath.UISSR
	slot7 = SummonEffectPool.getEffect(slot5, slot2[slot3])

	slot7:setAnimationName(SummonEnum.AnimationName[slot5])
	slot7:play()
	table.insert(slot0._summonUIEffects, slot7)
end

function slot0.createResultLuckyBagEffect(slot0, slot1, slot2, slot3)
	slot4 = SummonEnum.SummonLuckyBagPreloadPath.UILuckyBag
	slot5 = ""
	slot6 = slot1.luckyBagId

	if not SummonController.instance:getLastPoolId() then
		return
	end

	if not SummonConfig.instance:getLuckyBag(slot7, slot6) then
		return
	end

	slot9 = SummonEffectPool.getEffect(slot4, slot2[slot3])

	slot9:loadHeadTex(ResUrl.getSummonSceneTexture(slot8.sceneIcon))
	slot9:setAnimationName(SummonEnum.AnimationName[slot4])
	slot9:play()
	table.insert(slot0._summonUIEffects, slot9)
end

function slot0.onSummonAnimEnd(slot0)
	gohelper.setActive(slot0._goresult, true)
	gohelper.setActive(slot0._btnreturn.gameObject, false)
	gohelper.setActive(slot0._btnopenall.gameObject, slot0.summonResultCount > 1)
	slot0:initSummonResult()
end

function slot0.initSummonResult(slot0)
	slot0._waitEffectList = {}
	slot0._waitNormalEffectList = {}
	slot1 = {}
	slot1 = (slot0.summonResultCount <= 1 or SummonController.instance:getUINodes()) and SummonController.instance:getOnlyUINode()
	slot2 = {}

	for slot6, slot7 in pairs(slot0.summonResult) do
		if not slot0._resultitems[slot6] then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.cloneInPlace(slot0._goresultitem, "item" .. slot6)
			slot8.index = slot6
			slot8.btnopen = gohelper.findChildButtonWithAudio(slot8.go, "btn_open")

			slot8.btnopen:AddClickListener(function (slot0)
				uv0:openSummonResult(slot0.index)
				SummonController.instance:nextSummonPopupParam()
			end, slot8)

			slot0._resultitems[slot6] = slot8
		end

		if slot1[slot6] then
			slot12 = recthelper.worldPosToAnchorPos(gohelper.findChild(slot9, "btn/btnTopLeft").transform.position, slot0.viewGO.transform)
			slot13 = recthelper.worldPosToAnchorPos(gohelper.findChild(slot9, "btn/btnBottomRight").transform.position, slot0.viewGO.transform)

			recthelper.setAnchor(slot8.go.transform, (slot12.x + slot13.x) / 2, (slot12.y + slot13.y) / 2)
			recthelper.setHeight(slot8.go.transform, math.abs(slot12.y - slot13.y))
			recthelper.setWidth(slot8.go.transform, math.abs(slot13.x - slot12.x))
		end

		gohelper.setActive(slot8.btnopen.gameObject, true)
		gohelper.setActive(slot8.go, true)

		slot2[slot6] = true
	end

	for slot6, slot7 in pairs(slot0._resultitems) do
		if not slot2[slot6] then
			gohelper.setActive(slot7.go, false)
		end
	end
end

function slot0.openSummonResult(slot0, slot1, slot2)
	slot3, slot4 = SummonModel.instance:openSummonResult(slot1)
	slot6 = #SummonModel.instance:getSummonResult(false) > 1

	if slot3 then
		slot8 = nil

		if slot3.heroId ~= nil and slot7 ~= 0 then
			slot8 = HeroConfig.instance:getHeroCO(slot7)
		end

		if not slot2 and slot7 ~= 0 then
			logNormal(string.format("获得角色:%s", slot8.name))
		end

		if slot0._resultitems[slot1] then
			gohelper.setActive(slot0._resultitems[slot1].btnopen.gameObject, false)
		end

		if not slot6 or not slot2 or slot4 <= 0 or slot8 and slot8.rare >= 5 then
			table.insert(slot0._waitEffectList, {
				index = slot1,
				heroId = slot7,
				luckyBagId = slot3.luckyBagId
			})

			if not slot3:isLuckyBag() then
				slot0:insertSingleCharPopup(slot7, slot4, slot6)
			else
				slot0:insertLuckyBagPopup(slot3.luckyBagId)
			end
		elseif not slot2 then
			slot0._summonUIEffects[slot1]:loadHeroIcon(slot7)
		else
			table.insert(slot0._waitNormalEffectList, {
				index = slot1,
				heroId = slot7,
				luckyBagId = slot3.luckyBagId
			})
		end

		if SummonModel.instance:isAllOpened() then
			gohelper.setActive(slot0._btnopenall.gameObject, false)

			if not slot6 then
				gohelper.setActive(slot0._btnreturn.gameObject, true)
			else
				if not SummonController.instance:getLastPoolId() then
					return
				end

				if not SummonConfig.instance:getSummonPool(slot9) then
					return
				end

				SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, SummonController.instance:getResultViewName(), {
					summonResultList = slot5,
					curPool = slot10
				})
			end
		end
	end
end

function slot0.insertSingleCharPopup(slot0, slot1, slot2, slot3)
	if not SummonController.instance:getLastPoolId() then
		return
	end

	if not SummonConfig.instance:getSummonPool(slot4) then
		return
	end

	slot6 = nil

	if slot5.ticketId ~= 0 then
		slot6 = slot5.ticketId
	end

	if SummonController.instance:getMvSkinIdByHeroId(slot1) then
		-- Nothing
	end

	SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, {
		isSummon = true,
		heroId = slot1,
		duplicateCount = slot2,
		isSummonTen = slot3,
		summonTicketId = slot6,
		skipVideo = true,
		mvSkinId = slot8
	})
end

function slot0.insertLuckyBagPopup(slot0, slot1)
	if not SummonController.instance:getLastPoolId() then
		return
	end

	SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.GainCharacterView, ViewName.SummonGetLuckyBag, {
		luckyBagId = slot1,
		poolId = slot2
	})
end

function slot0._refreshIcons(slot0)
	if (not slot0._waitEffectList or #slot0._waitEffectList <= 1) and slot0._waitNormalEffectList and #slot0._waitNormalEffectList > 0 then
		for slot4, slot5 in ipairs(slot0._waitNormalEffectList) do
			slot7 = slot5.heroId

			if slot0._summonUIEffects[slot5.index] and slot7 ~= 0 then
				slot8:loadHeroIcon(slot7)
			end
		end
	end

	if not slot0._waitEffectList or #slot0._waitEffectList <= 0 then
		return
	end

	slot1 = slot0._waitEffectList[1]

	table.remove(slot0._waitEffectList, 1)

	slot3 = slot1.heroId

	if not slot0._summonUIEffects[slot1.index] or slot3 == 0 then
		return
	end

	slot4:loadHeroIcon(slot3)
end

function slot0._summonEnd(slot0)
	if not slot0._isDrawing then
		return
	end

	slot0._isDrawing = false

	SummonModel.instance:setIsDrawing(false)
	SummonController.instance:clearSummonPopupList()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonNormal))
	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	gohelper.setActive(slot0._gosummon, true)
	gohelper.setActive(slot0._goresult, false)
	slot0:recycleEffect()

	if slot0._sceneBoomEffectWrap then
		SummonEffectPool.returnEffect(slot0._sceneBoomEffectWrap)

		slot0._sceneBoomEffectWrap = nil
	end

	SummonController.instance:resetAnim()

	if not LoginController.instance:isEnteredGame() then
		return
	end

	SummonMainModel.instance:updateLastPoolId()

	slot1 = {
		jumpPoolId = SummonController.instance:getLastPoolId()
	}

	if SummonController.instance:getSummonEndOpenCallBack() then
		slot2:invoke()
		SummonController.instance:setSummonEndOpenCallBack(nil, )
	else
		SummonMainController.instance:openSummonView(slot1)
	end

	slot0:_gc()

	slot0.summonResult = {}
	slot0.summonResultCount = 0
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.CharacterGetView or slot1 == ViewName.SummonGetLuckyBag or slot1 == ViewName.LimitedRoleView then
		slot0:_refreshIcons()

		if slot0.summonResult then
			if slot0.summonResultCount == 1 and slot1 ~= ViewName.LimitedRoleView then
				slot0:_summonEnd()
			else
				SummonController.instance:nextSummonPopupParam()
			end
		end
	elseif slot1 == ViewName.CommonPropView and slot0.summonResult and slot0.summonResultCount > 1 then
		slot0:_summonEnd()
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == SummonController.instance:getResultViewName() then
		slot0:_refreshIcons()
	end
end

function slot0.recycleEffect(slot0)
	if slot0._summonUIEffects then
		for slot4 = 1, #slot0._summonUIEffects do
			SummonEffectPool.returnEffect(slot0._summonUIEffects[slot4])

			slot0._summonUIEffects[slot4] = nil
		end
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._resultitems) do
		slot5.btnopen:RemoveClickListener()
	end

	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._dragClickListener:RemoveClickDownListener()
	slot0._dragClickListener:RemoveClickUpListener()
end

function slot0._gc(slot0)
	slot0._summonCount = (slot0._summonCount or 0) + (slot0.summonResult and slot0.summonResultCount)

	if slot0._summonCount > 1 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, slot0)

		slot0._summonCount = 0
	end
end

function slot0._initTrackDragPos(slot0)
	slot1, slot2 = recthelper.getAnchor(slot0._godrag.transform)
	slot0._sdkTrackDragPosInfo = {
		st = {
			x = slot1,
			y = slot2
		},
		ed = {
			x = slot1,
			y = slot2
		}
	}
end

function slot0._markTrackDragPos(slot0, slot1, slot2)
	if slot1 then
		slot0._sdkTrackDragPosInfo.st.x = slot0._dragPosX
		slot0._sdkTrackDragPosInfo.st.y = slot0._dragPosY
	else
		slot0._sdkTrackDragPosInfo.ed.x = slot0._dragPosX
		slot0._sdkTrackDragPosInfo.ed.y = slot0._dragPosY
	end

	if slot2 then
		SummonController.instance:trackSummonClientEvent(false, slot0._sdkTrackDragPosInfo)
	end
end

return slot0
