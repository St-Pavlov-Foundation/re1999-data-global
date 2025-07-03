module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6EliminatePlayerSkill", package.seeall)

local var_0_0 = class("LengZhou6EliminatePlayerSkill", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorectMask = gohelper.findChild(arg_1_0.viewGO, "#go_rectMask")
	arg_1_0._txtskillTipDesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_skillTipDesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = typeof(ZProj.RectMaskHole)
local var_0_2 = SLFramework.UGUI.UIClickListener
local var_0_3 = UnityEngine.EventSystems.EventSystem

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._rectMaskHole = arg_4_0._gorectMask:GetComponent(var_0_1)
	arg_4_0._rectMaskHoleTr = arg_4_0._rectMaskHole.transform
	arg_4_0._rectMaskHole.enableClick = false
	arg_4_0._rectMaskHole.enableDrag = false
	arg_4_0._rectMaskHole.enablePress = false
	arg_4_0._rectMaskHole.enableTargetClick = false
	arg_4_0._rectMaskClick = var_0_2.Get(arg_4_0._gorectMask)

	arg_4_0._rectMaskClick:AddClickListener(arg_4_0.onClick, arg_4_0)
	arg_4_0:setCanvas()
end

function var_0_0.onClick(arg_5_0)
	local var_5_0 = UnityEngine.Input.mousePosition

	if arg_5_0._pointerEventData == nil then
		arg_5_0._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(var_0_3.current)
		arg_5_0._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	arg_5_0._pointerEventData.position = var_5_0

	if arg_5_0:isInRect(arg_5_0._pointerEventData) then
		arg_5_0:checkAndExecute()
	else
		arg_5_0:rectMaskClick()
	end
end

function var_0_0.checkAndExecute(arg_6_0)
	if arg_6_0._raycastResults == nil then
		return
	end

	var_0_3.current:RaycastAll(arg_6_0._pointerEventData, arg_6_0._raycastResults)

	local var_6_0 = arg_6_0._pointerEventData.pointerCurrentRaycast.gameObject

	if EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess then
		arg_6_0._raycastResults:Clear()
	end

	local var_6_1 = arg_6_0._raycastResults:GetEnumerator()

	while var_6_1:MoveNext() do
		local var_6_2 = var_6_1.Current.gameObject

		if var_6_2 ~= var_6_0 and var_6_2 ~= arg_6_0._gorectMask then
			local var_6_3 = var_6_2:GetComponent(typeof(UnityEngine.UI.Button))

			if not gohelper.isNil(var_6_3) then
				var_6_3:OnPointerClick(arg_6_0._pointerEventData)
			end
		end
	end
end

local var_0_4 = Vector2.New(0, 0)
local var_0_5 = UnityEngine.Rect.New(0, 0, 0, 0)

function var_0_0.isInRect(arg_7_0, arg_7_1)
	if arg_7_0._size == nil or arg_7_0._center == nil then
		return false
	end

	local var_7_0 = CameraMgr.instance:getUICamera()
	local var_7_1 = arg_7_0._center.x or 0
	local var_7_2 = arg_7_0._center.y or 0
	local var_7_3 = arg_7_0._size.x or 0
	local var_7_4 = arg_7_0._size.y or 0

	var_0_5:Set(var_7_1 - var_7_3 * 0.5, var_7_2 - var_7_4 * 0.5, var_7_3, var_7_4)

	local var_7_5, var_7_6 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_7_0._rectMaskHoleTr, arg_7_1.position, var_7_0, var_0_4)

	if var_7_5 and var_0_5:Contains(var_7_6) then
		return true
	end

	return false
end

function var_0_0.rectMaskClick(arg_8_0)
	if arg_8_0._rectMaskClickCb and arg_8_0._rectMaskClickCbTarget then
		arg_8_0._rectMaskClickCb(arg_8_0._rectMaskClickCbTarget)
	end
end

function var_0_0.setTargetTrAndHoleSize(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = Vector2(arg_9_2, arg_9_3)

	arg_9_0._rectMaskHole.size = var_9_0
	arg_9_4 = arg_9_4 or -30
	arg_9_5 = arg_9_5 or 0

	local var_9_1 = Vector2(arg_9_5, arg_9_4)

	arg_9_0._center = var_9_1
	arg_9_0._size = var_9_0

	arg_9_0._rectMaskHole:SetTarget(arg_9_1, var_9_1, var_9_1, nil)
end

function var_0_0.setCanvas(arg_10_0)
	arg_10_0._rectMaskHole.mainCanvas = ViewMgr.instance:getUICanvas()

	local var_10_0 = CameraMgr.instance:getUICamera()

	arg_10_0._rectMaskHole.mainCamera = var_10_0
	arg_10_0._rectMaskHole.uiCamera = var_10_0
end

function var_0_0.setClickCb(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._rectMaskClickCb = arg_11_1
	arg_11_0._rectMaskClickCbTarget = arg_11_2
end

function var_0_0.refreshSkillData(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0._rectMaskHole then
		arg_13_0._rectMaskHole:InitPointerLuaFunction(nil, nil)

		arg_13_0._rectMaskHole = nil
	end

	if arg_13_0._rectMaskClick then
		arg_13_0._rectMaskClick:RemoveClickListener()

		arg_13_0._rectMaskClick = nil
		arg_13_0._pointerEventData = nil
		arg_13_0._raycastResults = nil
	end

	arg_13_0._size = nil
	arg_13_0._center = nil
	arg_13_0._rectMaskClickCb = nil
	arg_13_0._rectMaskClickCbTarget = nil
end

return var_0_0
