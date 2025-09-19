local var_0_0 = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinScene", package.seeall)

local var_0_1 = class("HandbookSkinScene", BaseView)
local var_0_2 = "sence1down"
local var_0_3 = "sence1up"
local var_0_4 = "sence2down"
local var_0_5 = "sence2up"
local var_0_6 = 5
local var_0_7 = 0.00025
local var_0_8 = 0.15
local var_0_9 = {
	0.8333,
	0.6667,
	0.5,
	0.3333,
	0.1667
}
local var_0_10 = 0.25

var_0_1.SkinSuitId2SuitView = {
	[20011] = ViewName.HandbookSkinSuitDetailView2_1,
	[20012] = ViewName.HandbookSkinSuitDetailView2_2,
	[20014] = ViewName.HandbookSkinSuitDetailView2_4,
	[20009] = ViewName.HandbookSkinSuitDetailView1_9,
	[20018] = ViewName.HandbookSkinSuitDetailView2_8,
	[20013] = ViewName.HandbookSkinSuitDetailView2_3,
	[20010] = ViewName.HandbookSkinSuitDetailView2_0,
	[20019] = ViewName.HandbookSkinSuitDetailView3_0,
	[22003] = ViewName.HandbookSkinSuitDetailView2_9
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

function var_0_1.onDragging(arg_9_0, arg_9_1)
	if not arg_9_0._tarotMode then
		return
	end

	arg_9_0._dragging = true

	if arg_9_0._moveToOtherSuitAni then
		return
	end

	if arg_9_0._dragResetPosTweens and #arg_9_0._dragResetPosTweens > 0 then
		for iter_9_0 = 1, #arg_9_0._dragResetPosTweens do
			ZProj.TweenHelper.KillById(arg_9_0._dragResetPosTweens[iter_9_0])
		end

		arg_9_0._dragResetPosTweens = {}
	end

	local var_9_0 = var_0_7 * arg_9_1
	local var_9_1 = Mathf.Clamp(var_9_0, -var_0_8, var_0_8)
	local var_9_2 = false

	for iter_9_1, iter_9_2 in ipairs(arg_9_0._tarotCardAnimators) do
		local var_9_3 = arg_9_0._tarotCardAniProgress[iter_9_1]
		local var_9_4 = "slide"
		local var_9_5 = var_9_3 - var_9_1

		if var_9_5 >= arg_9_0._maxProgress then
			arg_9_0._tarotCardAniProgress[iter_9_1] = arg_9_0._minProgress + var_9_5 - arg_9_0._maxProgress
			arg_9_0._curLeftIdx = arg_9_0._curLeftIdx >= HandbookEnum.TarotSkinCount and 1 or arg_9_0._curLeftIdx + 1
			arg_9_0._curRightIdx = arg_9_0._curRightIdx >= HandbookEnum.TarotSkinCount and 1 or arg_9_0._curRightIdx + 1

			arg_9_0:setCardSprite(iter_9_1, arg_9_0._curRightIdx)

			arg_9_0._tarotCardIdx2SkinIdx[iter_9_1] = arg_9_0._curRightIdx

			local var_9_6 = true
		elseif var_9_5 <= arg_9_0._minProgress then
			arg_9_0._tarotCardAniProgress[iter_9_1] = arg_9_0._maxProgress + var_9_5 - arg_9_0._minProgress
			arg_9_0._curLeftIdx = arg_9_0._curLeftIdx <= 1 and HandbookEnum.TarotSkinCount or arg_9_0._curLeftIdx - 1
			arg_9_0._curRightIdx = arg_9_0._curRightIdx <= 1 and HandbookEnum.TarotSkinCount or arg_9_0._curRightIdx - 1

			arg_9_0:setCardSprite(iter_9_1, arg_9_0._curLeftIdx)

			arg_9_0._tarotCardIdx2SkinIdx[iter_9_1] = arg_9_0._curLeftIdx

			local var_9_7 = true
		else
			arg_9_0._tarotCardAniProgress[iter_9_1] = var_9_5
		end

		arg_9_0:UpdateAnimProgress(iter_9_2, var_9_4, arg_9_0._tarotCardAniProgress[iter_9_1])
	end
end

function var_0_1.onDragEnd(arg_10_0)
	if not arg_10_0._tarotMode then
		return
	end

	arg_10_0._dragging = false

	arg_10_0:doTarotCardPosResetTween()
end

function var_0_1.slideToSuitIdx(arg_11_0, arg_11_1)
	if arg_11_0._suitIdx ~= arg_11_1 then
		if arg_11_1 < arg_11_0._suitIdx then
			arg_11_0._sceneAnimator:SetFloat("Speed", 1)
			arg_11_0._sceneAnimator:Play(string.format("path_0%d_2", arg_11_1), 0, 0)
			AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_switch_2)
		else
			arg_11_0._sceneAnimator:SetFloat("Speed", 1)
			arg_11_0._sceneAnimator:Play(string.format("path_0%d_1", arg_11_0._suitIdx), 0, 0)
			AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_switch_1)
		end

		arg_11_0._moveToOtherSuitAni = true
		arg_11_0._suitIdx = arg_11_1

		TaskDispatcher.runDelay(arg_11_0._onMoveToOtherSuitAniDone, arg_11_0, 1)
		arg_11_0:_refreshPoint()
	end
end

function var_0_1._onMoveToOtherSuitAniDone(arg_12_0)
	arg_12_0._moveToOtherSuitAni = false
end

function var_0_1.onOpen(arg_13_0)
	CameraMgr.instance:switchVirtualCamera(1)

	local var_13_0 = arg_13_0.viewParam

	arg_13_0.sceneVisible = true
	arg_13_0._defaultSelectedIdx = var_13_0 and var_13_0.defaultSelectedIdx or 1
	arg_13_0._skinSuitGroupCfgList = HandbookConfig.instance:getSkinThemeGroupCfgs(true, true)

	arg_13_0:updateSuitGroupData(arg_13_0._defaultSelectedIdx)
	arg_13_0:_refreshScene(arg_13_0._curskinSuitGroupCfg.id)
	arg_13_0:_createSuitItems()
	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_amb_loop)
end

function var_0_1.setSceneActive(arg_14_0, arg_14_1)
	if arg_14_0._sceneRoot then
		gohelper.setActive(arg_14_0._sceneRoot, arg_14_1)
	end
end

function var_0_1._editableInitView(arg_15_0)
	arg_15_0:onScreenResize()

	local var_15_0 = CameraMgr.instance:getSceneRoot()

	arg_15_0._sceneRoot = UnityEngine.GameObject.New("HandbookSkinScene")

	gohelper.addChild(var_15_0, arg_15_0._sceneRoot)
end

function var_0_1.onScreenResize(arg_16_0)
	local var_16_0 = arg_16_0:_calcFovInternal()
	local var_16_1 = CameraMgr.instance:getVirtualCamera(1, 1)
	local var_16_2 = var_16_1.m_Lens

	var_16_1.m_Lens = Cinemachine.LensSettings.New(var_16_0, var_16_2.OrthographicSize, var_16_2.NearClipPlane, var_16_2.FarClipPlane, var_16_2.Dutch)
end

function var_0_1.resetCamera(arg_17_0)
	GameSceneMgr.instance:getCurScene().camera:resetParam()
end

function var_0_1.updateSuitGroupData(arg_18_0, arg_18_1)
	arg_18_0._curSelectedIdx = arg_18_1
	arg_18_0._curskinSuitGroupCfg = arg_18_0._skinSuitGroupCfgList[arg_18_0._curSelectedIdx]
	arg_18_0._curSuitGroupId = arg_18_0._curskinSuitGroupCfg.id
	arg_18_0._suitCfgList = HandbookConfig.instance:getSkinSuitCfgListInGroup(arg_18_0._curskinSuitGroupCfg.id)
	arg_18_0._suitCount = #arg_18_0._suitCfgList

	table.sort(arg_18_0._suitCfgList, arg_18_0._suitCfgSort)

	arg_18_0._suitIdx = 1

	arg_18_0:_refreshPoint()
end

function var_0_1._refreshPoint(arg_19_0)
	arg_19_0.viewContainer:dispatchEvent(HandbookEvent.SkinPointChanged, arg_19_0._suitIdx, arg_19_0._suitCount)
end

function var_0_1._suitCfgSort(arg_20_0, arg_20_1)
	if arg_20_0.show == 1 and arg_20_1.show == 0 then
		return true
	elseif arg_20_0.show == 0 and arg_20_1.show == 1 then
		return false
	else
		return arg_20_0.id > arg_20_1.id
	end
end

function var_0_1._refreshScene(arg_21_0, arg_21_1)
	if arg_21_0._curSceneGo then
		gohelper.destroy(arg_21_0._curSceneGo)

		arg_21_0._curSceneGo = nil
	end

	local var_21_0 = HandbookConfig.instance:getSkinThemeGroupCfg(arg_21_1).scenePath

	if string.nilorempty(var_21_0) then
		var_21_0 = HandbookEnum.SkinSuitGroupDefaultScene
	end

	local var_21_1 = arg_21_0:getResInst(var_21_0, arg_21_0._sceneRoot)

	arg_21_0._curSceneGo = var_21_1

	local var_21_2 = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(var_21_2, true)

	local var_21_3 = CameraMgr.instance:getCameraTraceGO()
	local var_21_4 = arg_21_0:_calcFovInternal()
	local var_21_5 = CameraMgr.instance:getVirtualCamera(1, 1)
	local var_21_6 = var_21_5.m_Lens

	var_21_5.m_Lens = Cinemachine.LensSettings.New(var_21_4, var_21_6.OrthographicSize, var_21_6.NearClipPlane, var_21_6.FarClipPlane, var_21_6.Dutch)
	arg_21_0._cameraRootAnimator = gohelper.onceAddComponent(var_21_3, typeof(UnityEngine.Animator))

	local var_21_7 = arg_21_0.viewContainer:getSetting().otherRes[1]
	local var_21_8 = arg_21_0.viewContainer._abLoader:getAssetItem(var_21_7):GetResource()

	arg_21_0._cameraRootAnimator.runtimeAnimatorController = var_21_8

	arg_21_0._cameraRootAnimator:Rebind()

	arg_21_0._sceneAnimator = arg_21_0._curSceneGo:GetComponent(gohelper.Type_Animator)
	arg_21_0._sceneAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_21_0._curSceneGo)

	local var_21_9 = gohelper.findChild(var_21_1, "cvure"):GetComponent(typeof(ZProj.SplineFollow))

	if var_21_9 == nil then
		return
	end

	var_21_9:Add(var_21_3.transform, 0)
end

function var_0_1._createSuitItems(arg_22_0)
	if arg_22_0._suitItemLoaderList and #arg_22_0._suitItemLoaderList > 0 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._suitItemLoaderList) do
			if iter_22_1 then
				iter_22_1:dispose()
			end
		end
	end

	arg_22_0._suitIconRootDict = arg_22_0:getUserDataTb_()

	local var_22_0 = arg_22_0._skinSuitGroupCfgList[arg_22_0._curSelectedIdx].id

	if HandbookEnum.SkinSuitId2SceneType[var_22_0] == HandbookEnum.SkinSuitSceneType.Tarot then
		local var_22_1 = arg_22_0._suitCfgList[1]
		local var_22_2 = gohelper.findChild(arg_22_0._curSceneGo, "sence/StandStill/Obj-Plant/near/quanzhuang/qiu")

		if var_22_2 then
			gohelper.setLayer(var_22_2, UnityLayer.Scene, true)
			arg_22_0:addBoxColliderListener(var_22_2, var_22_1.id, 0.5)
		end
	else
		arg_22_0._suitItemLoaderList = {}
		arg_22_0._suitId2IdxMap = {}

		for iter_22_2 = 1, #arg_22_0._suitCfgList do
			local var_22_3 = arg_22_0._suitCfgList[iter_22_2]

			arg_22_0._suitId2IdxMap[var_22_3.id] = iter_22_2

			local var_22_4 = gohelper.findChild(arg_22_0._curSceneGo, "sence/Icon/icon0" .. iter_22_2)

			if var_22_4 then
				gohelper.setLayer(var_22_4, UnityLayer.Scene, true)

				arg_22_0._suitIconRootDict[var_22_3.id] = var_22_4

				if var_22_3.highId == arg_22_0._curSuitGroupId then
					local var_22_5 = var_22_3.show and var_22_3.id or 10000
					local var_22_6 = string.format("scenes/v2a8_m_s17_pftj/prefab/icon_e/%d.prefab", var_22_5)
					local var_22_7 = PrefabInstantiate.Create(var_22_4)

					arg_22_0._suitItemLoaderList[#arg_22_0._suitItemLoaderList + 1] = var_22_7

					var_22_7:startLoad(var_22_6, function(arg_23_0)
						local var_23_0 = arg_23_0:getInstGO()

						if not gohelper.isNil(var_23_0) then
							local var_23_1 = MonoHelper.addLuaComOnceToGo(var_23_0, HandbookSkinSuitComp, {
								var_22_3.id
							})
						end
					end)

					local var_22_8 = gohelper.findChild(var_22_4, "root")

					if var_22_8 then
						gohelper.setActive(var_22_8, false)
					end
				end

				arg_22_0:addBoxColliderListener(var_22_4, var_22_3.id, 4)
			end
		end
	end
end

function var_0_1.addBoxColliderListener(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = var_0_1.addBoxCollider2D(arg_24_1, arg_24_3)

	var_24_0:AddClickListener(arg_24_0.onIconMouseDown, arg_24_0, arg_24_2)
	var_24_0:AddMouseUpListener(arg_24_0.onIconMouseUp, arg_24_0, arg_24_2)
end

function var_0_1.addBoxCollider2D(arg_25_0, arg_25_1)
	local var_25_0 = ZProj.BoxColliderClickListener.Get(arg_25_0)

	arg_25_1 = arg_25_1 or 4

	local var_25_1 = arg_25_0:GetComponent(typeof(UnityEngine.BoxCollider2D))

	if not var_25_1 then
		var_25_1 = gohelper.onceAddComponent(arg_25_0, typeof(UnityEngine.BoxCollider2D))
		var_25_1.size = Vector2(arg_25_1, arg_25_1)
	end

	var_25_1.enabled = true

	var_25_0:SetIgnoreUI(true)

	return var_25_0
end

function var_0_1.onIconMouseUp(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._mouseTouchSuitId

	arg_26_0._mouseTouchSuitId = nil

	if var_26_0 == arg_26_1 then
		local var_26_1 = UnityEngine.Input.mousePosition
		local var_26_2 = math.abs(arg_26_0._mouseX - var_26_1.x)
		local var_26_3 = math.abs(arg_26_0._mouseY - var_26_1.y)
		local var_26_4 = 15

		if var_26_2 <= var_26_4 and var_26_3 <= var_26_4 then
			arg_26_0:onIconClick(arg_26_1)
		end
	end
end

function var_0_1.onIconMouseDown(arg_27_0, arg_27_1)
	arg_27_0._mouseTouchSuitId = arg_27_1

	local var_27_0 = UnityEngine.Input.mousePosition

	arg_27_0._mouseX = var_27_0.x
	arg_27_0._mouseY = var_27_0.y
end

function var_0_1.onIconClick(arg_28_0, arg_28_1)
	if arg_28_0._moveToOtherSuitAni then
		return
	end

	if not arg_28_0.sceneVisible then
		return
	end

	local var_28_0 = arg_28_0._skinSuitGroupCfgList[arg_28_0._curSelectedIdx].id

	arg_28_0._suitId = arg_28_1

	if HandbookEnum.SkinSuitId2SceneType[var_28_0] == HandbookEnum.SkinSuitSceneType.Tarot then
		arg_28_0:enterTarotScene()
	else
		local var_28_1 = arg_28_0._suitId2IdxMap[arg_28_1]

		if arg_28_0._suitIdx == var_28_1 - 1 then
			arg_28_0._suitIdx = var_28_1

			local var_28_2 = var_28_1

			arg_28_0._sceneAnimator:SetFloat("Speed", 1)
			arg_28_0._sceneAnimator:Play(string.format("path_0%d_1", var_28_2 - 1), 0, 0)
			AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_switch_1)

			arg_28_0._moveToOtherSuitAni = true

			TaskDispatcher.runDelay(arg_28_0._onMoveToOtherSuitAniDone, arg_28_0, 1)
		else
			local var_28_3 = var_0_1.SkinSuitId2SuitView[arg_28_1]

			if var_28_3 then
				local var_28_4 = {
					skinThemeGroupId = arg_28_1
				}

				ViewMgr.instance:openView(var_28_3, var_28_4)
			end

			AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_open)
			HandbookController.instance:statSkinSuitDetail(arg_28_1)
		end

		arg_28_0:_refreshPoint()
	end
end

function var_0_1.enterTarotScene(arg_29_0)
	if arg_29_0._tarotMode then
		return
	end

	arg_29_0._tarotCardAniProgress = {}

	arg_29_0._sceneAnimatorPlayer:Play(var_0_0.Click, nil, nil)
	arg_29_0.viewContainer:dispatchEvent(HandbookEvent.OnClickTarotSkinSuit)

	arg_29_0._tarotCardDatas = {}
	arg_29_0._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(arg_29_0._suitId)

	local var_29_0 = arg_29_0._skinSuitCfg.skinContain
	local var_29_1 = arg_29_0._skinSuitCfg.tarotCardPath

	arg_29_0._skinIdList = string.splitToNumber(var_29_0, "|")
	arg_29_0._skinCardNameList = string.split(var_29_1, "|")

	for iter_29_0 = 1, HandbookEnum.TarotSkinCount do
		arg_29_0._tarotCardDatas[iter_29_0] = {}

		if iter_29_0 <= #arg_29_0._skinIdList then
			arg_29_0._tarotCardDatas[iter_29_0].path = string.format("%s/%s.png", HandbookEnum.TarotSkinCardDir, arg_29_0._skinCardNameList[iter_29_0])
			arg_29_0._tarotCardDatas[iter_29_0].skinId = arg_29_0._skinIdList[iter_29_0]
		else
			arg_29_0._tarotCardDatas[iter_29_0].path = HandbookEnum.TarotSkinDefaultCardPath
		end
	end

	arg_29_0._curLeftIdx = 1
	arg_29_0._curRightIdx = 5
	arg_29_0._tarotCardGos = arg_29_0:getUserDataTb_()
	arg_29_0._tarotCardSpriteRender = arg_29_0:getUserDataTb_()
	arg_29_0._tarotCardGlowSpriteRender = arg_29_0:getUserDataTb_()
	arg_29_0._tarotCardBackSpriteRender = arg_29_0:getUserDataTb_()
	arg_29_0._tarotCardAnimators = arg_29_0:getUserDataTb_()
	arg_29_0._tarotCardIdx2SkinIdx = {}

	for iter_29_1 = 1, var_0_6 do
		local var_29_2 = gohelper.findChild(arg_29_0._curSceneGo, string.format("#Card/card0%d", iter_29_1))

		arg_29_0._tarotCardGos[iter_29_1] = gohelper.findChild(var_29_2, "card")

		arg_29_0:addTarotCardBoxColliderListener(arg_29_0._tarotCardGos[iter_29_1], iter_29_1)

		arg_29_0._tarotCardAnimators[iter_29_1] = var_29_2:GetComponent(gohelper.Type_Animator)

		local var_29_3 = var_29_2.transform:Find("card/sprite").gameObject

		arg_29_0._tarotCardSpriteRender[iter_29_1] = var_29_3:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local var_29_4 = gohelper.findChild(var_29_2, "card/sprite/spriteglow")

		arg_29_0._tarotCardGlowSpriteRender[iter_29_1] = var_29_4:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local var_29_5 = gohelper.findChild(var_29_2, "card/back")

		arg_29_0._tarotCardBackSpriteRender[iter_29_1] = var_29_5:GetComponent(typeof(UnityEngine.SpriteRenderer))
		arg_29_0._tarotCardIdx2SkinIdx[iter_29_1] = iter_29_1
	end

	for iter_29_2 = 1, arg_29_0._curRightIdx do
		arg_29_0:setCardSprite(iter_29_2, iter_29_2)
	end

	arg_29_0:_setCardBackSprite()

	arg_29_0._enteringTarotMode = true

	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_special)
	TaskDispatcher.runDelay(arg_29_0.onTarotEnterAniDone, arg_29_0, 2.5)
end

function var_0_1.exitTarotScene(arg_30_0)
	if not arg_30_0._tarotMode then
		return
	end

	arg_30_0._tarotMode = false
	arg_30_0._tarotCardAniProgress = {}

	arg_30_0._sceneAnimatorPlayer:Play(var_0_0.Back, nil, nil)
	arg_30_0.viewContainer:dispatchEvent(HandbookEvent.OnExitTarotSkinSuit)
end

function var_0_1.onTarotEnterAniDone(arg_31_0)
	arg_31_0._enteringTarotMode = false
	arg_31_0._tarotMode = true
	arg_31_0._maxProgress = 0.916
	arg_31_0._minProgress = 0.083
	arg_31_0._tarotCardAniProgress[1] = var_0_9[1]
	arg_31_0._tarotCardAniProgress[2] = var_0_9[2]
	arg_31_0._tarotCardAniProgress[3] = var_0_9[3]
	arg_31_0._tarotCardAniProgress[4] = var_0_9[4]
	arg_31_0._tarotCardAniProgress[5] = var_0_9[5]

	for iter_31_0 = 1, var_0_6 do
		local var_31_0 = "slide"

		arg_31_0:UpdateAnimProgress(arg_31_0._tarotCardAnimators[iter_31_0], var_31_0, arg_31_0._tarotCardAniProgress[iter_31_0])
	end
end

function var_0_1.setCardSprite(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0._tarotCardDatas[arg_32_2].path

	arg_32_0._changeCardIdxMap = arg_32_0._changeCardIdxMap and arg_32_0._changeCardIdxMap or {}
	arg_32_0._cardLoaderxMap = arg_32_0._cardLoaderxMap and arg_32_0._cardLoaderxMap or {}

	if not string.nilorempty(var_32_0) then
		if arg_32_0._cardLoaderxMap[arg_32_1] then
			arg_32_0._cardLoaderxMap[arg_32_1]:dispose()
		end

		local var_32_1 = MultiAbLoader.New()

		arg_32_0._cardLoaderxMap[arg_32_1] = var_32_1
		arg_32_0._changeCardIdxMap[arg_32_1] = arg_32_2

		var_32_1:addPath(var_32_0)
		var_32_1:startLoad(arg_32_0._onLoadSpriteDone, arg_32_0)
	end
end

function var_0_1._onLoadSpriteDone(arg_33_0, arg_33_1)
	local var_33_0 = 0
	local var_33_1 = 0

	for iter_33_0, iter_33_1 in pairs(arg_33_0._cardLoaderxMap) do
		if iter_33_1 == arg_33_1 then
			var_33_0 = iter_33_0
			var_33_1 = arg_33_0._changeCardIdxMap[iter_33_0]

			break
		end
	end

	local var_33_2 = arg_33_0._tarotCardDatas[var_33_1].path
	local var_33_3 = arg_33_1:getAssetItem(var_33_2):GetResource(var_33_2)
	local var_33_4 = UnityEngine.Sprite.Create(var_33_3, UnityEngine.Rect.New(0, 0, var_33_3.width, var_33_3.height), Vector2.New(0.5, 0.5), 100, 0)
	local var_33_5 = arg_33_0._tarotCardSpriteRender[var_33_0]

	arg_33_0._tarotCardGlowSpriteRender[var_33_0].sprite = var_33_4
	var_33_5.sprite = var_33_4

	gohelper.setActive(var_33_5.gameObject, true)

	local var_33_6 = arg_33_0._tarotCardDatas[var_33_1].skinId

	var_33_5.color = (var_33_6 == nil or HeroModel.instance:checkHasSkin(var_33_6)) and Color.white or SLFramework.UGUI.GuiHelper.ParseColor("#7E7E7E")
end

function var_0_1._setCardBackSprite(arg_34_0)
	local var_34_0 = HandbookEnum.TarotSkinDefaultCardPath

	if not string.nilorempty(var_34_0) then
		if arg_34_0._cardbackLoader then
			arg_34_0._cardbackLoader:dispose()
		end

		local var_34_1 = MultiAbLoader.New()

		arg_34_0._cardbackLoader = var_34_1

		var_34_1:addPath(var_34_0)
		var_34_1:startLoad(arg_34_0._onCardBackLoadDone, arg_34_0)
	end
end

function var_0_1._onCardBackLoadDone(arg_35_0, arg_35_1)
	local var_35_0 = HandbookEnum.TarotSkinDefaultCardPath
	local var_35_1 = arg_35_1:getAssetItem(var_35_0):GetResource(var_35_0)
	local var_35_2 = UnityEngine.Sprite.Create(var_35_1, UnityEngine.Rect.New(0, 0, var_35_1.width, var_35_1.height), Vector2.New(0.5, 0.5), 100, 0)

	for iter_35_0, iter_35_1 in ipairs(arg_35_0._tarotCardBackSpriteRender) do
		iter_35_1.sprite = var_35_2
	end
end

function var_0_1.addTarotCardBoxColliderListener(arg_36_0, arg_36_1, arg_36_2)
	var_0_1.addBoxCollider2D(arg_36_1):AddMouseUpListener(arg_36_0.onTarotItemClickUp, arg_36_0, arg_36_2)
end

function var_0_1.onTarotItemClickUp(arg_37_0, arg_37_1)
	if arg_37_0._dragging or not arg_37_0._tarotMode then
		return
	end

	if not arg_37_0.sceneVisible then
		return
	end

	local var_37_0 = arg_37_0._tarotCardIdx2SkinIdx[arg_37_1]
	local var_37_1 = arg_37_0._tarotCardDatas[var_37_0].skinId
	local var_37_2 = SkinConfig.instance:getSkinCo(var_37_1)

	if not var_37_2 then
		return
	end

	local var_37_3 = var_37_2.characterId
	local var_37_4 = var_37_2.id
	local var_37_5 = {
		handbook = true,
		storyMode = true,
		heroId = var_37_3,
		skin = var_37_4,
		skinSuitId = arg_37_0._suitId
	}

	CharacterController.instance:openCharacterSkinView(var_37_5)
end

function var_0_1.doTarotCardPosResetTween(arg_38_0)
	arg_38_0._dragResetPosTweens = {}

	local var_38_0 = 0

	for iter_38_0 = 1, var_0_6 do
		local var_38_1 = arg_38_0._tarotCardAniProgress[iter_38_0]

		if iter_38_0 == 1 then
			var_38_0 = arg_38_0:_checkCardPosIdx(var_38_1)
		end

		local var_38_2 = var_38_0 + (iter_38_0 - 1)

		var_38_2 = var_38_2 > var_0_6 and var_38_2 - var_0_6 or var_38_2

		local var_38_3 = var_0_9[var_38_2]
		local var_38_4 = ZProj.TweenHelper.DOTweenFloat(var_38_1, var_38_3, var_0_10, arg_38_0.cardPosResetTweenFrameCallback, nil, arg_38_0, iter_38_0)

		arg_38_0._dragResetPosTweens[iter_38_0] = var_38_4
	end
end

function var_0_1.cardPosResetTweenFrameCallback(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = "slide"
	local var_39_1 = arg_39_0._tarotCardAnimators[arg_39_2]

	arg_39_0._tarotCardAniProgress[arg_39_2] = arg_39_1

	arg_39_0:UpdateAnimProgress(var_39_1, var_39_0, arg_39_1)
end

function var_0_1._checkCardPosIdx(arg_40_0, arg_40_1)
	local var_40_0 = math.huge
	local var_40_1 = 1

	for iter_40_0, iter_40_1 in ipairs(var_0_9) do
		local var_40_2 = math.abs(arg_40_1 - iter_40_1)

		if var_40_2 < var_40_0 then
			var_40_0 = var_40_2
			var_40_1 = iter_40_0
		end
	end

	return var_40_1
end

function var_0_1.isInTarotMode(arg_41_0)
	return arg_41_0._tarotMode or arg_41_0._enteringTarotMode
end

function var_0_1._calcFovInternal(arg_42_0)
	local var_42_0 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local var_42_1, var_42_2 = SettingsModel.instance:getCurrentScreenSize()

		var_42_0 = 16 * var_42_2 / 9 / var_42_1
	end

	local var_42_3 = HandbookEnum.TarotDefaultFOV * var_42_0
	local var_42_4, var_42_5 = arg_42_0:_getMinMaxFov()

	return (Mathf.Clamp(var_42_3, var_42_4, var_42_5))
end

function var_0_1._getMinMaxFov(arg_43_0)
	return 22, 40
end

function var_0_1.playCloseAni(arg_44_0)
	local var_44_0 = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(var_44_0, false)

	if arg_44_0._cameraRootAnimator then
		arg_44_0._cameraRootAnimator:Rebind()
		arg_44_0._cameraRootAnimator:Play(var_0_0.Close, 0, 0)
	end
end

function var_0_1.onClose(arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0.onTarotEnterAniDone, arg_45_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)

	if arg_45_0._cameraRootAnimator then
		arg_45_0._cameraRootAnimator:Rebind()
		arg_45_0._cameraRootAnimator:Play(var_0_0.Close, 0, 0)
		TaskDispatcher.runDelay(var_0_1.delayRemoveAnimator, arg_45_0, 0.1)
	end
end

function var_0_1.delayRemoveAnimator(arg_46_0)
	local var_46_0 = CameraMgr.instance:getCameraTraceGO()
	local var_46_1 = gohelper.onceAddComponent(var_46_0, typeof(UnityEngine.Animator))

	if var_46_1 then
		gohelper.removeComponent(var_46_1.gameObject, typeof(UnityEngine.Animator))
	end
end

function var_0_1.UpdateAnimProgress(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	arg_47_1:Play(arg_47_2, 0, arg_47_3)
end

function var_0_1.onDestroyView(arg_48_0)
	if arg_48_0._sceneRoot then
		gohelper.destroy(arg_48_0._sceneRoot)

		arg_48_0._sceneRoot = nil
	end

	if arg_48_0._cardLoaderxMap then
		for iter_48_0, iter_48_1 in pairs(arg_48_0._cardLoaderxMap) do
			if iter_48_1 then
				iter_48_1:dispose()
			end
		end

		arg_48_0._cardLoaderxMap = nil
	end

	if arg_48_0._cardbackLoader then
		arg_48_0._cardbackLoader:dispose()
	end

	if arg_48_0._suitItemLoaderList and #arg_48_0._suitItemLoaderList > 0 then
		for iter_48_2, iter_48_3 in ipairs(arg_48_0._suitItemLoaderList) do
			if iter_48_3 then
				iter_48_3:dispose()
			end
		end
	end
end

function var_0_1.onCloseFinish(arg_49_0)
	CameraMgr.instance:getMainCamera().fieldOfView = 35
end

return var_0_1
