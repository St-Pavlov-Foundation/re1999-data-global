local var_0_0 = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinScene", package.seeall)

local var_0_1 = class("HandbookSkinScene", BaseView)
local var_0_2 = "sence1down"
local var_0_3 = "sence1up"
local var_0_4 = "sence2down"
local var_0_5 = "sence2up"
local var_0_6 = 5
local var_0_7 = 0.00075
local var_0_8 = 0.0003
local var_0_9 = 0.15
local var_0_10 = {
	0.8333,
	0.6667,
	0.5,
	0.3333,
	0.1667
}
local var_0_11 = 0.25

var_0_1.SkinSuitId2SuitView = {
	[20011] = ViewName.HandbookSkinSuitDetailView2_1,
	[20012] = ViewName.HandbookSkinSuitDetailView2_2,
	[20014] = ViewName.HandbookSkinSuitDetailView2_4,
	[20009] = ViewName.HandbookSkinSuitDetailView1_9,
	[20018] = ViewName.HandbookSkinSuitDetailView2_8,
	[20013] = ViewName.HandbookSkinSuitDetailView2_3,
	[20010] = ViewName.HandbookSkinSuitDetailView2_0,
	[20019] = ViewName.HandbookSkinSuitDetailView3_0,
	[22003] = ViewName.HandbookSkinSuitDetailView2_9,
	[20020] = ViewName.HandbookSkinSuitDetailView3_1,
	[20021] = ViewName.HandbookSkinSuitDetailView3_2
}

function var_0_1.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0.onScreenResize, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.OnClickSkinSuitFloorItem, arg_2_0.onClickFloorItem, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.SwitchSkinSuitFloorDone, arg_2_0.onSwitchSkinSuitFloorDone, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.SkinBookSlideToPre, arg_2_0.onSlideToPre, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.SkinBookSlideToNext, arg_2_0.onSlideToNext, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.SkinBookSlide, arg_2_0.onDragging, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.SkinBookSlideEnd, arg_2_0.onDragEnd, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.SkinBookSlideByClick, arg_2_0.onSlideByClick, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.SkinBookDropListOpen, arg_2_0.onSkinSuitDropListShow, arg_2_0)
end

function var_0_1.removeEvents(arg_3_0)
	return
end

function var_0_1.onClickFloorItem(arg_4_0, arg_4_1)
	arg_4_0._tarotMode = false

	if arg_4_0._curSelectedIdx == arg_4_1 then
		return
	end

	if arg_4_1 > arg_4_0._curSelectedIdx then
		arg_4_0._isUp = true
		arg_4_0._curSelectedIdx = arg_4_1

		arg_4_0._sceneAnimatorPlayer:Play(var_0_2, arg_4_0.onOriSceneAniDone, arg_4_0)
	else
		arg_4_0._isUp = false
		arg_4_0._curSelectedIdx = arg_4_1

		arg_4_0._sceneAnimatorPlayer:Play(var_0_3, arg_4_0.onOriSceneAniDone, arg_4_0)
	end

	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_floor_switch)
end

function var_0_1.onOriSceneAniDone(arg_5_0)
	arg_5_0:updateSuitGroupData(arg_5_0._curSelectedIdx)
	arg_5_0:_refreshScene(arg_5_0._skinSuitGroupCfgList[arg_5_0._curSelectedIdx].id)
	arg_5_0:_createSuitItems()

	arg_5_0._suitCurveProgresss = 0
	arg_5_0._moveToOtherSuitAni = false
end

function var_0_1.onSwitchSkinSuitFloorDone(arg_6_0)
	if arg_6_0._isUp then
		arg_6_0._sceneAnimatorPlayer:Play(var_0_4)
	else
		arg_6_0._sceneAnimatorPlayer:Play(var_0_5)
	end
end

function var_0_1.onSlideToPre(arg_7_0)
	if arg_7_0._moveToOtherSuitAni then
		return
	end

	if arg_7_0._suitIdx > 1 then
		arg_7_0:slideToSuitIdx(arg_7_0._suitIdx - 1)
	end
end

function var_0_1.onSlideToNext(arg_8_0)
	if arg_8_0._moveToOtherSuitAni then
		return
	end

	if arg_8_0._suitIdx < arg_8_0._suitCount then
		arg_8_0:slideToSuitIdx(arg_8_0._suitIdx + 1)
	end
end

function var_0_1.onSkinSuitDropListShow(arg_9_0, arg_9_1)
	arg_9_0._suitDropListShow = arg_9_1
end

function var_0_1.onSlideByClick(arg_10_0, arg_10_1)
	if arg_10_0._moveToOtherSuitAni then
		return
	end

	if arg_10_1 ~= arg_10_0._suitIdx then
		arg_10_0:slideToSuitIdx(arg_10_1)
	end
end

function var_0_1.onDragging(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._inTarotGroup then
		if arg_11_1 ~= 0 or arg_11_2 ~= 0 then
			local var_11_0 = math.abs(arg_11_1) > math.abs(arg_11_2) and arg_11_1 or arg_11_2

			arg_11_0._sceneAnimator:SetFloat("Speed", 0)

			arg_11_0._suitCurveProgresss = arg_11_0._suitCurveProgresss or 0
			arg_11_0._suitCurveProgresss = Mathf.Clamp(arg_11_0._suitCurveProgresss + var_11_0 * var_0_8, 0, 1)

			arg_11_0:UpdateAnimProgress(arg_11_0._sceneAnimator, "path_last", arg_11_0._suitCurveProgresss)

			arg_11_0._moveToOtherSuitAni = true
		end
	else
		if arg_11_0._enteringTarotMode or not arg_11_0._tarotMode then
			return
		end

		arg_11_0._dragging = true

		if arg_11_0._moveToOtherSuitAni then
			return
		end

		if arg_11_0._dragResetPosTweens and #arg_11_0._dragResetPosTweens > 0 then
			for iter_11_0 = 1, #arg_11_0._dragResetPosTweens do
				ZProj.TweenHelper.KillById(arg_11_0._dragResetPosTweens[iter_11_0])
			end

			arg_11_0._dragResetPosTweens = {}
		end

		local var_11_1 = var_0_7 * arg_11_1
		local var_11_2 = Mathf.Clamp(var_11_1, -var_0_9, var_0_9)
		local var_11_3 = false

		for iter_11_1, iter_11_2 in ipairs(arg_11_0._tarotCardAnimators) do
			local var_11_4 = arg_11_0._tarotCardAniProgress[iter_11_1]
			local var_11_5 = "slide"
			local var_11_6 = var_11_4 - var_11_2

			if var_11_6 >= arg_11_0._maxProgress then
				arg_11_0._tarotCardAniProgress[iter_11_1] = arg_11_0._minProgress + var_11_6 - arg_11_0._maxProgress
				arg_11_0._curLeftIdx = arg_11_0._curLeftIdx >= HandbookEnum.TarotSkinCount and 1 or arg_11_0._curLeftIdx + 1
				arg_11_0._curRightIdx = arg_11_0._curRightIdx >= HandbookEnum.TarotSkinCount and 1 or arg_11_0._curRightIdx + 1

				arg_11_0:setCardSprite(iter_11_1, arg_11_0._curRightIdx)

				arg_11_0._tarotCardIdx2SkinIdx[iter_11_1] = arg_11_0._curRightIdx

				local var_11_7 = true
			elseif var_11_6 <= arg_11_0._minProgress then
				arg_11_0._tarotCardAniProgress[iter_11_1] = arg_11_0._maxProgress + var_11_6 - arg_11_0._minProgress
				arg_11_0._curLeftIdx = arg_11_0._curLeftIdx <= 1 and HandbookEnum.TarotSkinCount or arg_11_0._curLeftIdx - 1
				arg_11_0._curRightIdx = arg_11_0._curRightIdx <= 1 and HandbookEnum.TarotSkinCount or arg_11_0._curRightIdx - 1

				arg_11_0:setCardSprite(iter_11_1, arg_11_0._curLeftIdx)

				arg_11_0._tarotCardIdx2SkinIdx[iter_11_1] = arg_11_0._curLeftIdx

				local var_11_8 = true
			else
				arg_11_0._tarotCardAniProgress[iter_11_1] = var_11_6
			end

			arg_11_0:UpdateAnimProgress(iter_11_2, var_11_5, arg_11_0._tarotCardAniProgress[iter_11_1])
		end
	end
end

function var_0_1.onDragEnd(arg_12_0)
	if not arg_12_0._tarotMode then
		arg_12_0._moveToOtherSuitAni = false

		arg_12_0:slideToClosestSuit()
	else
		arg_12_0._dragging = false

		arg_12_0:doTarotCardPosResetTween()
	end
end

function var_0_1.slideToSuitIdx(arg_13_0, arg_13_1)
	if arg_13_0._suitIdx ~= arg_13_1 then
		arg_13_0._sceneAnimator:SetFloat("Speed", 0)

		local var_13_0 = (arg_13_0._suitIdx - 1) / (arg_13_0._suitCount - 1)

		arg_13_0._suitCurveProgresss = (arg_13_1 - 1) / (arg_13_0._suitCount - 1)

		local var_13_1 = ZProj.TweenHelper.DOTweenFloat(var_13_0, arg_13_0._suitCurveProgresss, 1, arg_13_0.slideSuitAniUpdate, nil, arg_13_0)

		arg_13_0:UpdateAnimProgress(arg_13_0._sceneAnimator, "path_last", var_13_0)
		AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_switch_2)

		arg_13_0._moveToOtherSuitAni = true
		arg_13_0._suitIdx = arg_13_1

		TaskDispatcher.runDelay(arg_13_0._onMoveToOtherSuitAniDone, arg_13_0, 1)
		UIBlockMgr.instance:startBlock(UIBlockKey.WaitItemAnimeDone)
		arg_13_0:_refreshPoint()
	end
end

function var_0_1.slideToClosestSuit(arg_14_0)
	if arg_14_0._suitCount <= 1 then
		return
	end

	local var_14_0 = 1
	local var_14_1 = 0
	local var_14_2 = 0

	for iter_14_0 = 0, arg_14_0._suitCount - 1 do
		local var_14_3 = iter_14_0 / (arg_14_0._suitCount - 1)
		local var_14_4 = math.abs(var_14_3 - arg_14_0._suitCurveProgresss)

		if var_14_4 < var_14_0 then
			var_14_0 = var_14_4
			var_14_1 = iter_14_0 + 1
			var_14_2 = var_14_3
		end
	end

	arg_14_0._sceneAnimator:SetFloat("Speed", 0)

	local var_14_5 = ZProj.TweenHelper.DOTweenFloat(arg_14_0._suitCurveProgresss, var_14_2, 0.25, arg_14_0.slideSuitAniUpdate, nil, arg_14_0)

	arg_14_0._moveToOtherSuitAni = true
	arg_14_0._suitIdx = var_14_1
	arg_14_0._suitCurveProgresss = var_14_2

	TaskDispatcher.runDelay(arg_14_0._onMoveToOtherSuitAniDone, arg_14_0, 0.25)
	arg_14_0:_refreshPoint()
end

function var_0_1.slideSuitAniUpdate(arg_15_0, arg_15_1)
	arg_15_0:UpdateAnimProgress(arg_15_0._sceneAnimator, "path_last", arg_15_1)
end

function var_0_1._onMoveToOtherSuitAniDone(arg_16_0)
	arg_16_0._moveToOtherSuitAni = false

	UIBlockMgr.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
end

function var_0_1.onOpen(arg_17_0)
	CameraMgr.instance:switchVirtualCamera(1)

	local var_17_0 = arg_17_0.viewParam

	arg_17_0.sceneVisible = true
	arg_17_0._defaultSelectedIdx = var_17_0 and var_17_0.defaultSelectedIdx or 1
	arg_17_0._skinSuitGroupCfgList = HandbookConfig.instance:getSkinThemeGroupCfgs(true, true)

	arg_17_0:updateSuitGroupData(arg_17_0._defaultSelectedIdx)
	arg_17_0:_refreshScene(arg_17_0._curskinSuitGroupCfg.id)
	arg_17_0:_createSuitItems()
end

function var_0_1.setSceneActive(arg_18_0, arg_18_1)
	if arg_18_0._sceneRoot then
		gohelper.setActive(arg_18_0._sceneRoot, arg_18_1)
	end
end

function var_0_1._editableInitView(arg_19_0)
	arg_19_0:onScreenResize()

	local var_19_0 = CameraMgr.instance:getSceneRoot()

	arg_19_0._sceneRoot = UnityEngine.GameObject.New("HandbookSkinScene")

	gohelper.addChild(var_19_0, arg_19_0._sceneRoot)
end

function var_0_1.onScreenResize(arg_20_0)
	local var_20_0 = arg_20_0:_calcFovInternal()
	local var_20_1 = CameraMgr.instance:getVirtualCamera(1, 1)
	local var_20_2 = var_20_1.m_Lens

	var_20_1.m_Lens = Cinemachine.LensSettings.New(var_20_0, var_20_2.OrthographicSize, var_20_2.NearClipPlane, var_20_2.FarClipPlane, var_20_2.Dutch)
end

function var_0_1.resetCamera(arg_21_0)
	GameSceneMgr.instance:getCurScene().camera:resetParam()
end

function var_0_1.updateSuitGroupData(arg_22_0, arg_22_1)
	arg_22_0._curSelectedIdx = arg_22_1
	arg_22_0._curskinSuitGroupCfg = arg_22_0._skinSuitGroupCfgList[arg_22_0._curSelectedIdx]
	arg_22_0._curSuitGroupId = arg_22_0._curskinSuitGroupCfg.id
	arg_22_0._suitCfgList = HandbookConfig.instance:getSkinSuitCfgListInGroup(arg_22_0._curskinSuitGroupCfg.id)
	arg_22_0._suitCount = #arg_22_0._suitCfgList

	table.sort(arg_22_0._suitCfgList, arg_22_0._suitCfgSort)

	arg_22_0._suitIdx = 1

	arg_22_0:_refreshPoint()
end

function var_0_1._refreshPoint(arg_23_0)
	arg_23_0.viewContainer:dispatchEvent(HandbookEvent.SkinPointChanged, arg_23_0._suitIdx, arg_23_0._suitCount)
end

function var_0_1._suitCfgSort(arg_24_0, arg_24_1)
	if arg_24_0.show == 1 and arg_24_1.show == 0 then
		return true
	elseif arg_24_0.show == 0 and arg_24_1.show == 1 then
		return false
	else
		return arg_24_0.id > arg_24_1.id
	end
end

function var_0_1._refreshScene(arg_25_0, arg_25_1)
	if arg_25_0._curSceneGo then
		gohelper.destroy(arg_25_0._curSceneGo)

		arg_25_0._curSceneGo = nil
	end

	local var_25_0 = HandbookConfig.instance:getSkinThemeGroupCfg(arg_25_1).scenePath

	if string.nilorempty(var_25_0) then
		var_25_0 = HandbookEnum.SkinSuitGroupDefaultScene
	end

	local var_25_1 = arg_25_0:getResInst(var_25_0, arg_25_0._sceneRoot)

	arg_25_0._curSceneGo = var_25_1

	local var_25_2 = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(var_25_2, true)

	local var_25_3 = CameraMgr.instance:getCameraTraceGO()
	local var_25_4 = arg_25_0:_calcFovInternal()
	local var_25_5 = CameraMgr.instance:getVirtualCamera(1, 1)
	local var_25_6 = var_25_5.m_Lens

	var_25_5.m_Lens = Cinemachine.LensSettings.New(var_25_4, var_25_6.OrthographicSize, var_25_6.NearClipPlane, var_25_6.FarClipPlane, var_25_6.Dutch)
	arg_25_0._cameraRootAnimator = gohelper.onceAddComponent(var_25_3, typeof(UnityEngine.Animator))

	local var_25_7 = arg_25_0.viewContainer:getSetting().otherRes[1]
	local var_25_8 = arg_25_0.viewContainer._abLoader:getAssetItem(var_25_7):GetResource()

	arg_25_0._cameraRootAnimator.runtimeAnimatorController = var_25_8

	arg_25_0._cameraRootAnimator:Rebind()

	arg_25_0._sceneAnimator = arg_25_0._curSceneGo:GetComponent(gohelper.Type_Animator)
	arg_25_0._sceneAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_25_0._curSceneGo)

	local var_25_9 = gohelper.findChild(var_25_1, "cvure"):GetComponent(typeof(ZProj.SplineFollow))

	if var_25_9 == nil then
		return
	end

	var_25_9:Add(var_25_3.transform, 0)

	arg_25_0._inTarotGroup = HandbookEnum.SkinSuitId2SceneType[arg_25_1] == HandbookEnum.SkinSuitSceneType.Tarot
end

function var_0_1._createSuitItems(arg_26_0)
	if arg_26_0._suitItemLoaderList and #arg_26_0._suitItemLoaderList > 0 then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0._suitItemLoaderList) do
			if iter_26_1 then
				iter_26_1:dispose()
			end
		end
	end

	arg_26_0._suitIconRootDict = arg_26_0:getUserDataTb_()

	local var_26_0 = arg_26_0._skinSuitGroupCfgList[arg_26_0._curSelectedIdx].id

	if HandbookEnum.SkinSuitId2SceneType[var_26_0] == HandbookEnum.SkinSuitSceneType.Tarot then
		local var_26_1 = arg_26_0._suitCfgList[1]
		local var_26_2 = gohelper.findChild(arg_26_0._curSceneGo, "sence/StandStill/Obj-Plant/near/quanzhuang/qiu")

		if var_26_2 then
			gohelper.setLayer(var_26_2, UnityLayer.Scene, true)
			arg_26_0:addBoxColliderListener(var_26_2, var_26_1.id, 0.5)
		end
	else
		arg_26_0._suitItemLoaderList = {}
		arg_26_0._suitId2IdxMap = {}

		for iter_26_2 = 1, #arg_26_0._suitCfgList do
			local var_26_3 = arg_26_0._suitCfgList[iter_26_2]

			arg_26_0._suitId2IdxMap[var_26_3.id] = iter_26_2

			local var_26_4 = gohelper.findChild(arg_26_0._curSceneGo, "sence/Icon/icon0" .. iter_26_2)

			if var_26_4 then
				gohelper.setLayer(var_26_4, UnityLayer.Scene, true)

				arg_26_0._suitIconRootDict[var_26_3.id] = var_26_4

				if var_26_3.highId == arg_26_0._curSuitGroupId then
					local var_26_5 = var_26_3.show and var_26_3.id or 10000
					local var_26_6 = string.format("scenes/v2a8_m_s17_pftj/prefab/icon_e/%d.prefab", var_26_5)
					local var_26_7 = PrefabInstantiate.Create(var_26_4)

					arg_26_0._suitItemLoaderList[#arg_26_0._suitItemLoaderList + 1] = var_26_7

					var_26_7:startLoad(var_26_6, function(arg_27_0)
						local var_27_0 = arg_27_0:getInstGO()

						if not gohelper.isNil(var_27_0) then
							local var_27_1 = MonoHelper.addLuaComOnceToGo(var_27_0, HandbookSkinSuitComp, {
								var_26_3.id
							})
						end
					end)

					local var_26_8 = gohelper.findChild(var_26_4, "root")

					if var_26_8 then
						gohelper.setActive(var_26_8, false)
					end
				end

				arg_26_0:addBoxColliderListener(var_26_4, var_26_3.id, 4)
			end
		end
	end
end

function var_0_1.addBoxColliderListener(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = var_0_1.addBoxCollider2D(arg_28_1, arg_28_3)

	var_28_0:AddClickListener(arg_28_0.onIconMouseDown, arg_28_0, arg_28_2)
	var_28_0:AddMouseUpListener(arg_28_0.onIconMouseUp, arg_28_0, arg_28_2)
end

function var_0_1.addBoxCollider2D(arg_29_0, arg_29_1)
	local var_29_0 = ZProj.BoxColliderClickListener.Get(arg_29_0)

	arg_29_1 = arg_29_1 or 4

	local var_29_1 = arg_29_0:GetComponent(typeof(UnityEngine.BoxCollider2D))

	if not var_29_1 then
		var_29_1 = gohelper.onceAddComponent(arg_29_0, typeof(UnityEngine.BoxCollider2D))
		var_29_1.size = Vector2(arg_29_1, arg_29_1)
	end

	var_29_1.enabled = true

	var_29_0:SetIgnoreUI(true)

	return var_29_0
end

function var_0_1.onIconMouseUp(arg_30_0, arg_30_1)
	if arg_30_0._suitDropListShow then
		return
	end

	local var_30_0 = arg_30_0._mouseTouchSuitId

	arg_30_0._mouseTouchSuitId = nil

	if var_30_0 == arg_30_1 then
		local var_30_1 = UnityEngine.Input.mousePosition
		local var_30_2 = math.abs(arg_30_0._mouseX - var_30_1.x)
		local var_30_3 = math.abs(arg_30_0._mouseY - var_30_1.y)
		local var_30_4 = 15

		if var_30_2 <= var_30_4 and var_30_3 <= var_30_4 then
			arg_30_0:onIconClick(arg_30_1)
		end
	end
end

function var_0_1.onIconMouseDown(arg_31_0, arg_31_1)
	if arg_31_0._suitDropListShow then
		return
	end

	arg_31_0._mouseTouchSuitId = arg_31_1

	local var_31_0 = UnityEngine.Input.mousePosition

	arg_31_0._mouseX = var_31_0.x
	arg_31_0._mouseY = var_31_0.y
end

function var_0_1.onIconClick(arg_32_0, arg_32_1)
	if arg_32_0._moveToOtherSuitAni then
		return
	end

	if not arg_32_0.sceneVisible then
		return
	end

	local var_32_0 = arg_32_0._skinSuitGroupCfgList[arg_32_0._curSelectedIdx].id

	arg_32_0._suitId = arg_32_1

	if HandbookEnum.SkinSuitId2SceneType[var_32_0] == HandbookEnum.SkinSuitSceneType.Tarot then
		arg_32_0:enterTarotScene()
	else
		local var_32_1 = arg_32_0._suitId2IdxMap[arg_32_1]

		if arg_32_0._suitIdx ~= var_32_1 then
			arg_32_0:slideToSuitIdx(var_32_1)

			arg_32_0._suitIdx = var_32_1
		else
			local var_32_2 = var_0_1.SkinSuitId2SuitView[arg_32_1]

			if var_32_2 then
				local var_32_3 = {
					skinThemeGroupId = arg_32_1
				}

				ViewMgr.instance:openView(var_32_2, var_32_3)
			end

			AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_open)
			HandbookController.instance:statSkinSuitDetail(arg_32_1)
		end

		arg_32_0:_refreshPoint()
	end
end

function var_0_1.enterTarotScene(arg_33_0)
	if arg_33_0._tarotMode then
		return
	end

	arg_33_0._tarotCardAniProgress = {}

	arg_33_0._sceneAnimatorPlayer:Play(var_0_0.Click, nil, nil)
	arg_33_0.viewContainer:dispatchEvent(HandbookEvent.OnClickTarotSkinSuit)

	arg_33_0._tarotCardDatas = {}
	arg_33_0._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(arg_33_0._suitId)

	local var_33_0 = arg_33_0._skinSuitCfg.skinContain
	local var_33_1 = arg_33_0._skinSuitCfg.tarotCardPath

	arg_33_0._skinIdList = string.splitToNumber(var_33_0, "|")
	arg_33_0._skinCardNameList = string.split(var_33_1, "|")

	for iter_33_0 = 1, HandbookEnum.TarotSkinCount do
		arg_33_0._tarotCardDatas[iter_33_0] = {}

		if iter_33_0 <= #arg_33_0._skinIdList then
			arg_33_0._tarotCardDatas[iter_33_0].path = string.format("%s/%s.png", HandbookEnum.TarotSkinCardDir, arg_33_0._skinCardNameList[iter_33_0])
			arg_33_0._tarotCardDatas[iter_33_0].skinId = arg_33_0._skinIdList[iter_33_0]
		else
			arg_33_0._tarotCardDatas[iter_33_0].path = HandbookEnum.TarotSkinDefaultCardPath
		end
	end

	arg_33_0._curLeftIdx = 1
	arg_33_0._curRightIdx = 5
	arg_33_0._tarotCardGos = arg_33_0:getUserDataTb_()
	arg_33_0._tarotCardSpriteRender = arg_33_0:getUserDataTb_()
	arg_33_0._tarotCardGlowSpriteRender = arg_33_0:getUserDataTb_()
	arg_33_0._tarotCardBackSpriteRender = arg_33_0:getUserDataTb_()
	arg_33_0._tarotCardAnimators = arg_33_0:getUserDataTb_()
	arg_33_0._tarotCardIdx2SkinIdx = {}

	for iter_33_1 = 1, var_0_6 do
		local var_33_2 = gohelper.findChild(arg_33_0._curSceneGo, string.format("#Card/card0%d", iter_33_1))

		arg_33_0._tarotCardGos[iter_33_1] = gohelper.findChild(var_33_2, "card")

		arg_33_0:addTarotCardBoxColliderListener(arg_33_0._tarotCardGos[iter_33_1], iter_33_1)

		arg_33_0._tarotCardAnimators[iter_33_1] = var_33_2:GetComponent(gohelper.Type_Animator)

		local var_33_3 = var_33_2.transform:Find("card/sprite").gameObject

		arg_33_0._tarotCardSpriteRender[iter_33_1] = var_33_3:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local var_33_4 = gohelper.findChild(var_33_2, "card/sprite/spriteglow")

		arg_33_0._tarotCardGlowSpriteRender[iter_33_1] = var_33_4:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local var_33_5 = gohelper.findChild(var_33_2, "card/back")

		arg_33_0._tarotCardBackSpriteRender[iter_33_1] = var_33_5:GetComponent(typeof(UnityEngine.SpriteRenderer))
		arg_33_0._tarotCardIdx2SkinIdx[iter_33_1] = iter_33_1
	end

	for iter_33_2 = 1, arg_33_0._curRightIdx do
		arg_33_0:setCardSprite(iter_33_2, iter_33_2)
	end

	arg_33_0:_setCardBackSprite()

	arg_33_0._enteringTarotMode = true

	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_special)
	TaskDispatcher.runDelay(arg_33_0.onTarotEnterAniDone, arg_33_0, 2.5)
end

function var_0_1.exitTarotScene(arg_34_0)
	if not arg_34_0._tarotMode then
		return
	end

	arg_34_0._tarotMode = false
	arg_34_0._tarotCardAniProgress = {}

	arg_34_0._sceneAnimatorPlayer:Play(var_0_0.Back, nil, nil)
	arg_34_0.viewContainer:dispatchEvent(HandbookEvent.OnExitTarotSkinSuit)
end

function var_0_1.onTarotEnterAniDone(arg_35_0)
	arg_35_0._enteringTarotMode = false
	arg_35_0._tarotMode = true
	arg_35_0._maxProgress = 0.916
	arg_35_0._minProgress = 0.083
	arg_35_0._tarotCardAniProgress[1] = var_0_10[1]
	arg_35_0._tarotCardAniProgress[2] = var_0_10[2]
	arg_35_0._tarotCardAniProgress[3] = var_0_10[3]
	arg_35_0._tarotCardAniProgress[4] = var_0_10[4]
	arg_35_0._tarotCardAniProgress[5] = var_0_10[5]

	for iter_35_0 = 1, var_0_6 do
		local var_35_0 = "slide"

		arg_35_0:UpdateAnimProgress(arg_35_0._tarotCardAnimators[iter_35_0], var_35_0, arg_35_0._tarotCardAniProgress[iter_35_0])
	end
end

function var_0_1.setCardSprite(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0._tarotCardDatas[arg_36_2].path

	arg_36_0._changeCardIdxMap = arg_36_0._changeCardIdxMap and arg_36_0._changeCardIdxMap or {}
	arg_36_0._cardLoaderxMap = arg_36_0._cardLoaderxMap and arg_36_0._cardLoaderxMap or {}

	if not string.nilorempty(var_36_0) then
		if arg_36_0._cardLoaderxMap[arg_36_1] then
			arg_36_0._cardLoaderxMap[arg_36_1]:dispose()
		end

		local var_36_1 = MultiAbLoader.New()

		arg_36_0._cardLoaderxMap[arg_36_1] = var_36_1
		arg_36_0._changeCardIdxMap[arg_36_1] = arg_36_2

		var_36_1:addPath(var_36_0)
		var_36_1:startLoad(arg_36_0._onLoadSpriteDone, arg_36_0)
	end
end

function var_0_1._onLoadSpriteDone(arg_37_0, arg_37_1)
	local var_37_0 = 0
	local var_37_1 = 0

	for iter_37_0, iter_37_1 in pairs(arg_37_0._cardLoaderxMap) do
		if iter_37_1 == arg_37_1 then
			var_37_0 = iter_37_0
			var_37_1 = arg_37_0._changeCardIdxMap[iter_37_0]

			break
		end
	end

	local var_37_2 = arg_37_0._tarotCardDatas[var_37_1].path
	local var_37_3 = arg_37_1:getAssetItem(var_37_2):GetResource(var_37_2)
	local var_37_4 = UnityEngine.Sprite.Create(var_37_3, UnityEngine.Rect.New(0, 0, var_37_3.width, var_37_3.height), Vector2.New(0.5, 0.5), 100, 0)
	local var_37_5 = arg_37_0._tarotCardSpriteRender[var_37_0]

	arg_37_0._tarotCardGlowSpriteRender[var_37_0].sprite = var_37_4
	var_37_5.sprite = var_37_4

	gohelper.setActive(var_37_5.gameObject, true)

	local var_37_6 = arg_37_0._tarotCardDatas[var_37_1].skinId

	var_37_5.color = (var_37_6 == nil or HeroModel.instance:checkHasSkin(var_37_6)) and Color.white or SLFramework.UGUI.GuiHelper.ParseColor("#7E7E7E")
end

function var_0_1._setCardBackSprite(arg_38_0)
	local var_38_0 = HandbookEnum.TarotSkinDefaultCardPath

	if not string.nilorempty(var_38_0) then
		if arg_38_0._cardbackLoader then
			arg_38_0._cardbackLoader:dispose()
		end

		local var_38_1 = MultiAbLoader.New()

		arg_38_0._cardbackLoader = var_38_1

		var_38_1:addPath(var_38_0)
		var_38_1:startLoad(arg_38_0._onCardBackLoadDone, arg_38_0)
	end
end

function var_0_1._onCardBackLoadDone(arg_39_0, arg_39_1)
	local var_39_0 = HandbookEnum.TarotSkinDefaultCardPath
	local var_39_1 = arg_39_1:getAssetItem(var_39_0):GetResource(var_39_0)
	local var_39_2 = UnityEngine.Sprite.Create(var_39_1, UnityEngine.Rect.New(0, 0, var_39_1.width, var_39_1.height), Vector2.New(0.5, 0.5), 100, 0)

	for iter_39_0, iter_39_1 in ipairs(arg_39_0._tarotCardBackSpriteRender) do
		iter_39_1.sprite = var_39_2
	end
end

function var_0_1.addTarotCardBoxColliderListener(arg_40_0, arg_40_1, arg_40_2)
	var_0_1.addBoxCollider2D(arg_40_1):AddMouseUpListener(arg_40_0.onTarotItemClickUp, arg_40_0, arg_40_2)
end

function var_0_1.onTarotItemClickUp(arg_41_0, arg_41_1)
	if arg_41_0._dragging or not arg_41_0._tarotMode then
		return
	end

	if not arg_41_0.sceneVisible then
		return
	end

	local var_41_0 = arg_41_0._tarotCardIdx2SkinIdx[arg_41_1]
	local var_41_1 = arg_41_0._tarotCardDatas[var_41_0].skinId
	local var_41_2 = SkinConfig.instance:getSkinCo(var_41_1)

	if not var_41_2 then
		return
	end

	local var_41_3 = var_41_2.characterId
	local var_41_4 = var_41_2.id
	local var_41_5 = {
		handbook = true,
		storyMode = true,
		heroId = var_41_3,
		skin = var_41_4,
		skinSuitId = arg_41_0._suitId
	}

	CharacterController.instance:openCharacterSkinView(var_41_5)
end

function var_0_1.doTarotCardPosResetTween(arg_42_0)
	arg_42_0._dragResetPosTweens = {}

	local var_42_0 = 0

	for iter_42_0 = 1, var_0_6 do
		local var_42_1 = arg_42_0._tarotCardAniProgress[iter_42_0]

		if iter_42_0 == 1 then
			var_42_0 = arg_42_0:_checkCardPosIdx(var_42_1)
		end

		local var_42_2 = var_42_0 + (iter_42_0 - 1)

		var_42_2 = var_42_2 > var_0_6 and var_42_2 - var_0_6 or var_42_2

		local var_42_3 = var_0_10[var_42_2]
		local var_42_4 = ZProj.TweenHelper.DOTweenFloat(var_42_1, var_42_3, var_0_11, arg_42_0.cardPosResetTweenFrameCallback, nil, arg_42_0, iter_42_0)

		arg_42_0._dragResetPosTweens[iter_42_0] = var_42_4
	end
end

function var_0_1.cardPosResetTweenFrameCallback(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = "slide"
	local var_43_1 = arg_43_0._tarotCardAnimators[arg_43_2]

	arg_43_0._tarotCardAniProgress[arg_43_2] = arg_43_1

	arg_43_0:UpdateAnimProgress(var_43_1, var_43_0, arg_43_1)
end

function var_0_1._checkCardPosIdx(arg_44_0, arg_44_1)
	local var_44_0 = math.huge
	local var_44_1 = 1

	for iter_44_0, iter_44_1 in ipairs(var_0_10) do
		local var_44_2 = math.abs(arg_44_1 - iter_44_1)

		if var_44_2 < var_44_0 then
			var_44_0 = var_44_2
			var_44_1 = iter_44_0
		end
	end

	return var_44_1
end

function var_0_1.isInTarotMode(arg_45_0)
	return arg_45_0._tarotMode or arg_45_0._enteringTarotMode
end

function var_0_1._calcFovInternal(arg_46_0)
	local var_46_0 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local var_46_1, var_46_2 = SettingsModel.instance:getCurrentScreenSize()

		var_46_0 = 16 * var_46_2 / 9 / var_46_1
	end

	local var_46_3 = HandbookEnum.TarotDefaultFOV * var_46_0
	local var_46_4, var_46_5 = arg_46_0:_getMinMaxFov()

	return (Mathf.Clamp(var_46_3, var_46_4, var_46_5))
end

function var_0_1._getMinMaxFov(arg_47_0)
	return 22, 40
end

function var_0_1.playCloseAni(arg_48_0)
	local var_48_0 = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(var_48_0, false)

	if arg_48_0._cameraRootAnimator then
		arg_48_0._cameraRootAnimator:Rebind()
		arg_48_0._cameraRootAnimator:Play(var_0_0.Close, 0, 0)
	end
end

function var_0_1.onClose(arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0.onTarotEnterAniDone, arg_49_0)

	if arg_49_0._cameraRootAnimator then
		arg_49_0._cameraRootAnimator:Rebind()
		arg_49_0._cameraRootAnimator:Play(var_0_0.Close, 0, 0)
		TaskDispatcher.runDelay(var_0_1.delayRemoveAnimator, arg_49_0, 0.1)
	end
end

function var_0_1.delayRemoveAnimator(arg_50_0)
	local var_50_0 = CameraMgr.instance:getCameraTraceGO()
	local var_50_1 = gohelper.onceAddComponent(var_50_0, typeof(UnityEngine.Animator))

	if var_50_1 then
		gohelper.removeComponent(var_50_1.gameObject, typeof(UnityEngine.Animator))
	end
end

function var_0_1.UpdateAnimProgress(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	arg_51_1:Play(arg_51_2, 0, arg_51_3)
end

function var_0_1.onDestroyView(arg_52_0)
	if arg_52_0._sceneRoot then
		gohelper.destroy(arg_52_0._sceneRoot)

		arg_52_0._sceneRoot = nil
	end

	if arg_52_0._cardLoaderxMap then
		for iter_52_0, iter_52_1 in pairs(arg_52_0._cardLoaderxMap) do
			if iter_52_1 then
				iter_52_1:dispose()
			end
		end

		arg_52_0._cardLoaderxMap = nil
	end

	if arg_52_0._cardbackLoader then
		arg_52_0._cardbackLoader:dispose()
	end

	if arg_52_0._suitItemLoaderList and #arg_52_0._suitItemLoaderList > 0 then
		for iter_52_2, iter_52_3 in ipairs(arg_52_0._suitItemLoaderList) do
			if iter_52_3 then
				iter_52_3:dispose()
			end
		end
	end
end

function var_0_1.onCloseFinish(arg_53_0)
	CameraMgr.instance:getMainCamera().fieldOfView = 35

	BGMSwitchController.instance:checkStartMainBGM(true)
end

return var_0_1
