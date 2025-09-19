module("modules.logic.survival.view.map.comp.SurvivalUnitUIItem", package.seeall)

local var_0_0 = class("SurvivalUnitUIItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._unitMo = arg_1_1
	arg_1_0._isShowStar = false

	if arg_1_1.unitType == SurvivalEnum.UnitType.NPC then
		local var_1_0 = SurvivalMapModel.instance:getSceneMo()

		if next(var_1_0.needNpcTags) then
			local var_1_1 = string.splitToNumber(arg_1_1.co.tag, "#")

			if var_1_1 then
				for iter_1_0, iter_1_1 in ipairs(var_1_1) do
					if var_1_0.needNpcTags[iter_1_1] then
						arg_1_0._isShowStar = true

						break
					end
				end
			end
		end
	end
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_1.transform

	transformhelper.setLocalPos(arg_2_0.trans, 9999, 9999, 0)

	arg_2_0._imagebubble = gohelper.findChildImage(arg_2_1, "#image_bubble")
	arg_2_0._imageicon = gohelper.findChildImage(arg_2_1, "#image_icon")
	arg_2_0._golevel = gohelper.findChild(arg_2_1, "level")
	arg_2_0._txtlevel = gohelper.findChildTextMesh(arg_2_1, "level/#txt_level")
	arg_2_0._goarrow = gohelper.findChild(arg_2_1, "arrow")
	arg_2_0._goarrowright = gohelper.findChild(arg_2_1, "arrow/right")
	arg_2_0._goarrowtop = gohelper.findChild(arg_2_1, "arrow/top")
	arg_2_0._goarrowleft = gohelper.findChild(arg_2_1, "arrow/left")
	arg_2_0._goarrowbottom = gohelper.findChild(arg_2_1, "arrow/bottom")
	arg_2_0._imagearrowright = gohelper.findChildImage(arg_2_1, "arrow/right")
	arg_2_0._imagearrowtop = gohelper.findChildImage(arg_2_1, "arrow/top")
	arg_2_0._imagearrowleft = gohelper.findChildImage(arg_2_1, "arrow/left")
	arg_2_0._imagearrowbottom = gohelper.findChildImage(arg_2_1, "arrow/bottom")
	arg_2_0._gostar = gohelper.findChildImage(arg_2_1, "star")
	arg_2_0._anim = gohelper.findChildAnim(arg_2_1, "")
	arg_2_0._grid = gohelper.findChild(arg_2_1, "grid")
	arg_2_0._item = gohelper.findChild(arg_2_1, "grid/item")

	local var_2_0 = gohelper.findChild(arg_2_1, "goRaycast")

	arg_2_0._click = gohelper.getClick(var_2_0)
	arg_2_0._isFollow = arg_2_0:getIsFollow()

	arg_2_0:initFollow()
	arg_2_0:refreshInfo()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._click:AddClickListener(arg_3_0._onClickIcon, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapPlayerPosChange, arg_3_0._onMapPlayerPosChange, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitPosChange, arg_3_0._onMapUnitPosChange, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnUnitBeginMove, arg_3_0._onMapUnitBeginMove, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnUnitEndMove, arg_3_0._onMapUnitEndMove, arg_3_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_3_0._onScreenResize, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._click:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapPlayerPosChange, arg_4_0._onMapPlayerPosChange, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitPosChange, arg_4_0._onMapUnitPosChange, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnUnitBeginMove, arg_4_0._onMapUnitBeginMove, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnUnitEndMove, arg_4_0._onMapUnitEndMove, arg_4_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_4_0._onScreenResize, arg_4_0)
end

function var_0_0.onStart(arg_5_0)
	arg_5_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false

	arg_5_0:checkEnabled()
end

function var_0_0.initFollow(arg_6_0)
	if not arg_6_0._isFollow then
		gohelper.setActive(arg_6_0._goarrow, false)

		arg_6_0._uiFollower = gohelper.onceAddComponent(arg_6_0.go, typeof(ZProj.UIFollower))
	else
		gohelper.setActive(arg_6_0._goarrow, true)

		arg_6_0._uiFollower = gohelper.onceAddComponent(arg_6_0.go, typeof(ZProj.UIFollowerInRange))

		arg_6_0._uiFollower:SetBoundArrow(arg_6_0._goarrowleft, arg_6_0._goarrowright, arg_6_0._goarrowtop, arg_6_0._goarrowbottom)
		arg_6_0._uiFollower:SetArrowCallback(arg_6_0._onArrowChange, arg_6_0)
		arg_6_0:_onScreenResize()
	end

	arg_6_0._uiFollower:SetEnable(true)

	local var_6_0 = SurvivalMapHelper.instance:getEntity(arg_6_0._unitMo.id)
	local var_6_1 = CameraMgr.instance:getMainCamera()
	local var_6_2 = CameraMgr.instance:getUICamera()
	local var_6_3 = ViewMgr.instance:getUIRoot().transform

	arg_6_0._uiFollower:Set(var_6_1, var_6_2, var_6_3, var_6_0.go.transform, 0, 0.4, 0, 0, 0)
	arg_6_0:checkEnabled()
end

function var_0_0._onScreenResize(arg_7_0)
	if not arg_7_0._isFollow or not arg_7_0._uiFollower then
		return
	end

	local var_7_0 = ViewMgr.instance:getUIRoot().transform
	local var_7_1 = recthelper.getWidth(var_7_0)
	local var_7_2 = recthelper.getHeight(var_7_0)

	var_7_2 = var_7_1 / var_7_2 < 1.7777777777777777 and 1080 or var_7_2

	local var_7_3 = var_7_1 / 2
	local var_7_4 = var_7_2 / 2

	arg_7_0._uiFollower:SetRange(-var_7_3 + 250, var_7_3 - 150, -var_7_4 + 210, var_7_4 - 110)
end

function var_0_0._onFollowTaskUpdate(arg_8_0)
	local var_8_0 = arg_8_0:getIsFollow()

	if var_8_0 ~= arg_8_0._isFollow then
		arg_8_0._isFollow = var_8_0

		UnityEngine.Object.DestroyImmediate(arg_8_0._uiFollower)
		arg_8_0:initFollow()
	end
end

function var_0_0.getIsFollow(arg_9_0)
	local var_9_0 = arg_9_0._unitMo.co and arg_9_0._unitMo.co.subType

	if tabletool.indexOf(SurvivalConfig.instance:getHighValueUnitSubTypes(), var_9_0) then
		return true
	end

	local var_9_1 = SurvivalMapModel.instance:getSceneMo().followTask

	return arg_9_0._unitMo.unitType == SurvivalEnum.UnitType.Exit or arg_9_0._unitMo.id == var_9_1.followUnitUid or arg_9_0._unitMo.id == 0
end

function var_0_0.refreshInfo(arg_10_0)
	gohelper.setActive(arg_10_0._golevel, false)
	arg_10_0:updateIconAndBg()
	arg_10_0:checkEnabled()
end

function var_0_0.updateIconAndBg(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = SurvivalUnitIconHelper.instance:getUnitIconAndBg(arg_11_0._unitMo)

	UISpriteSetMgr.instance:setSurvivalSprite(arg_11_0._imageicon, var_11_0)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_11_0._imagebubble, var_11_1)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_11_0._imagearrowright, var_11_2)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_11_0._imagearrowtop, var_11_2)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_11_0._imagearrowleft, var_11_2)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_11_0._imagearrowbottom, var_11_2)
end

function var_0_0._onMapPlayerPosChange(arg_12_0)
	arg_12_0:checkEnabled()
end

function var_0_0._onMapUnitPosChange(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:checkEnabled()
end

function var_0_0._onMapUnitBeginMove(arg_14_0, arg_14_1)
	if arg_14_1 ~= arg_14_0._unitMo.id then
		return
	end

	arg_14_0._isUnitMoving = true

	if arg_14_0._isMult then
		arg_14_0:checkEnabled()
	end
end

function var_0_0._onMapUnitEndMove(arg_15_0, arg_15_1)
	if arg_15_1 ~= arg_15_0._unitMo.id then
		return
	end

	arg_15_0._isUnitMoving = false

	arg_15_0:checkEnabled()
end

function var_0_0.checkEnabled(arg_16_0)
	local var_16_0 = SurvivalMapModel.instance:getSceneMo().player.pos == arg_16_0._unitMo.pos
	local var_16_1 = SurvivalMapModel.instance:getSceneMo():getUnitListByPos(arg_16_0._unitMo.pos)
	local var_16_2 = var_16_1[1] == arg_16_0._unitMo and not var_16_0

	arg_16_0._uiFollower:SetEnable(var_16_2)

	arg_16_0._uiFollower.enabled = var_16_2

	arg_16_0._uiFollower:ForceUpdate()

	arg_16_0._isMult = false

	if not var_16_2 then
		transformhelper.setLocalPos(arg_16_0.trans, 9999, 9999, 0)
	elseif #var_16_1 > 1 then
		arg_16_0._isMult = true

		gohelper.setActive(arg_16_0._grid, not arg_16_0._isUnitMoving)
		tabletool.revert(var_16_1)
		gohelper.CreateObjList(arg_16_0, arg_16_0._createIcons, var_16_1, arg_16_0._grid, arg_16_0._item, nil, nil, nil, 0)
	else
		gohelper.setActive(arg_16_0._grid, false)
	end

	gohelper.setActive(arg_16_0._imagebubble, not arg_16_0._isArrowShow and (not arg_16_0._isMult or arg_16_0._isUnitMoving))
	gohelper.setActive(arg_16_0._imageicon, not arg_16_0._isMult or arg_16_0._isUnitMoving)
	gohelper.setActive(arg_16_0._gostar, (not arg_16_0._isMult or arg_16_0._isUnitMoving) and arg_16_0._isShowStar)
end

function var_0_0._createIcons(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = gohelper.findChildImage(arg_17_1, "#image_bubble")
	local var_17_1 = gohelper.findChildImage(arg_17_1, "#image_icon")
	local var_17_2, var_17_3 = SurvivalUnitIconHelper.instance:getUnitIconAndBg(arg_17_2)

	UISpriteSetMgr.instance:setSurvivalSprite(var_17_1, var_17_2)
	UISpriteSetMgr.instance:setSurvivalSprite(var_17_0, var_17_3 .. "2")
end

function var_0_0._onClickIcon(arg_18_0)
	local var_18_0, var_18_1, var_18_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_18_0._unitMo.pos.q, arg_18_0._unitMo.pos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(var_18_0, var_18_1, var_18_2))
end

function var_0_0._onArrowChange(arg_19_0, arg_19_1)
	arg_19_0._isArrowShow = arg_19_1

	gohelper.setActive(arg_19_0._click, arg_19_1)
	gohelper.setActive(arg_19_0._imagebubble, not arg_19_1 and not arg_19_0._isMult)
end

function var_0_0.playCloseAnim(arg_20_0)
	arg_20_0._anim:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_20_0.dispose, arg_20_0, 0.2)
end

function var_0_0.dispose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.dispose, arg_21_0)
	gohelper.destroy(arg_21_0.go)
end

return var_0_0
