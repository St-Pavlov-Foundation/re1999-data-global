module("modules.logic.sp01.assassin2.outside.view.AssassinQuestMapEditView", package.seeall)

local var_0_0 = class("AssassinQuestMapEditView", BaseView)
local var_0_1 = 300
local var_0_2 = 50
local var_0_3 = -352
local var_0_4 = 0

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "root/#go_drag/simage_fullbg/#go_container")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.frameHandle = UpdateBeat:CreateListener(arg_2_0.onFrame, arg_2_0)

	UpdateBeat:AddListener(arg_2_0.frameHandle)
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._questEditItemTab then
		for iter_3_0, iter_3_1 in pairs(arg_3_0._questEditItemTab) do
			iter_3_1.btnQuestItem:RemoveClickListener()
		end
	end

	if arg_3_0._btnexport then
		arg_3_0._btnexport:RemoveClickListener()
	end

	if arg_3_0._drag then
		arg_3_0._drag:RemoveDragBeginListener()
		arg_3_0._drag:RemoveDragListener()
		arg_3_0._drag:RemoveDragEndListener()
	end
end

function var_0_0.onFrame(arg_4_0)
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Q) then
		if arg_4_0._isEditMode then
			arg_4_0._isEditMode = false

			gohelper.setActive(arg_4_0.goDrag, false)
		else
			if gohelper.isNil(arg_4_0.goEditBtnList) then
				arg_4_0:initEditorTools()
				arg_4_0:initQuestCoList()
			end

			arg_4_0._isEditMode = true

			GameFacade.showToastString(string.format("进入编辑模式，MapId : %s", arg_4_0._mapId))
		end

		gohelper.setActive(arg_4_0.goEditBtnList, arg_4_0._isEditMode)
	end
end

function var_0_0._btnquestItemOnClick(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._questEditItemTab[arg_5_1]
	local var_5_1 = var_5_0 and var_5_0.questId
	local var_5_2 = AssassinConfig.instance:getQuestCfg(var_5_1)

	if not var_5_2 then
		return
	end

	local var_5_3 = arg_5_0._curEditItemIndex and arg_5_0._questEditItemTab[arg_5_0._curEditItemIndex]

	if var_5_3 then
		SLFramework.UGUI.GuiHelper.SetColor(var_5_3.txtQuestName, "#FFFFFF")
	end

	if arg_5_0._curEditItemIndex == arg_5_1 then
		arg_5_0._editItemIcon = nil
		arg_5_0._curEditItemIndex = false
	else
		arg_5_0._editItemIcon = arg_5_0:_getQuestIconItem(var_5_2.id)
		arg_5_0._curEditItemIndex = arg_5_1
	end

	gohelper.setActive(arg_5_0.goDrag, arg_5_0._curEditItemIndex)

	local var_5_4 = arg_5_0._curEditItemIndex and arg_5_0._questEditItemTab[arg_5_0._curEditItemIndex]

	if var_5_4 then
		SLFramework.UGUI.GuiHelper.SetColor(var_5_4.txtQuestName, "#FF0000")
	end
end

function var_0_0._getQuestIconItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.viewContainer.assassinMapView

	if var_6_0 and var_6_0._showQuestItemDict then
		return var_6_0._showQuestItemDict[arg_6_1]
	end
end

function var_0_0._onDrag(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._editItemIcon then
		return
	end

	local var_7_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_7_0._transcontainer)

	arg_7_0._editItemIcon:setPosition(var_7_0.x, var_7_0.y)
end

function var_0_0._btnexportOnClick(arg_8_0)
	if not arg_8_0._editItemIcon then
		GameFacade.showToastString("Export Failed\nNo selected edit item")

		return
	end

	local var_8_0 = arg_8_0._editItemIcon:getQuestId()
	local var_8_1, var_8_2 = arg_8_0._editItemIcon:getPosition()
	local var_8_3 = string.format("%.2f", var_8_1)
	local var_8_4 = string.format("%.2f", var_8_2)
	local var_8_5 = string.format("%s#%s", var_8_3, var_8_4)

	ZProj.UGUIHelper.CopyText(var_8_5)
	GameFacade.showToastString(string.format("Export Quest:%s\nPos:(%s, %s)", var_8_0, var_8_3, var_8_4))
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._isEditMode = false
	arg_9_0._transcontainer = arg_9_0._gocontainer.transform
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._mapId = arg_10_0.viewParam and arg_10_0.viewParam.mapId
end

function var_0_0._createBtnNotGraphic(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = gohelper.create2d(arg_11_1, arg_11_2)

	ZProj.UGUIHelper.SetColorAlpha(gohelper.onceAddComponent(var_11_0, gohelper.Type_Image), 0)
	gohelper.onceAddComponent(var_11_0, typeof(UnityEngine.UI.Button))

	return var_11_0, gohelper.findChildButtonWithAudio(arg_11_1, arg_11_2, AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
end

function var_0_0.initEditorTools(arg_12_0)
	local var_12_0 = arg_12_0.viewGO:GetComponentInChildren(gohelper.Type_TextMesh)

	arg_12_0._txtCompFont = var_12_0 and var_12_0.font
	arg_12_0.goDrag = arg_12_0:_createBtnNotGraphic(arg_12_0._goroot, "edit_DragArea")

	local var_12_1 = recthelper.getWidth(arg_12_0._transcontainer)
	local var_12_2 = recthelper.getHeight(arg_12_0._transcontainer)
	local var_12_3, var_12_4 = recthelper.getAnchor(arg_12_0._transcontainer)

	recthelper.setSize(arg_12_0.goDrag.transform, var_12_1, var_12_2)
	recthelper.setAnchor(arg_12_0.goDrag.transform, var_12_3, var_12_4)

	arg_12_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_12_0.goDrag)

	arg_12_0._drag:AddDragBeginListener(arg_12_0._onDrag, arg_12_0)
	arg_12_0._drag:AddDragListener(arg_12_0._onDrag, arg_12_0)
	arg_12_0._drag:AddDragEndListener(arg_12_0._onDrag, arg_12_0)

	arg_12_0._questEditItemTab = arg_12_0:getUserDataTb_()
end

function var_0_0.initQuestCoList(arg_13_0)
	local var_13_0 = AssassinOutsideModel.instance:getMapUnlockQuestIdList(arg_13_0._mapId)

	arg_13_0.goEditBtnList = gohelper.create2d(arg_13_0.viewGO, "edit_BtnList")

	local var_13_1 = var_0_1
	local var_13_2 = var_0_2 * #var_13_0

	recthelper.setSize(arg_13_0.goEditBtnList.transform, var_13_1, var_13_2)
	recthelper.setAnchor(arg_13_0.goEditBtnList.transform, var_0_3, var_0_4)

	local var_13_3 = gohelper.onceAddComponent(arg_13_0.goEditBtnList, gohelper.Type_VerticalLayoutGroup)

	var_13_3.childControlWidth = false
	var_13_3.childControlHeight = false
	var_13_3.childForceExpandWidth = false
	var_13_3.childForceExpandHeight = false

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_4 = AssassinConfig.instance:getQuestCfg(iter_13_1)

		arg_13_0:_createSingleQuestEditItem(arg_13_0.goEditBtnList, iter_13_0, iter_13_1).txtQuestName.text = var_13_4.title
	end

	arg_13_0._goexportbtn, arg_13_0._btnexport = arg_13_0:_createBtnNotGraphic(arg_13_0.goEditBtnList, "edit_export")

	recthelper.setSize(arg_13_0._goexportbtn.transform, var_0_1, var_0_2)

	local var_13_5 = gohelper.create2d(arg_13_0._goexportbtn, "txt_name")

	recthelper.setSize(var_13_5.transform, var_0_1, var_0_2)

	local var_13_6 = gohelper.onceAddComponent(var_13_5, gohelper.Type_TextMesh)

	var_13_6.text = "Export"
	var_13_6.font = arg_13_0._txtCompFont

	arg_13_0._btnexport:AddClickListener(arg_13_0._btnexportOnClick, arg_13_0)
end

function var_0_0._createSingleQuestEditItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0._questEditItemTab[arg_14_2]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.go, var_14_0.btnQuestItem = arg_14_0:_createBtnNotGraphic(arg_14_1, "edit_questitem_" .. arg_14_2)

		var_14_0.btnQuestItem:AddClickListener(arg_14_0._btnquestItemOnClick, arg_14_0, arg_14_2)

		local var_14_1 = gohelper.create2d(var_14_0.go, "txt_name")

		var_14_0.txtQuestName = gohelper.onceAddComponent(var_14_1, gohelper.Type_TextMesh)
		var_14_0.txtQuestName.font = arg_14_0._txtCompFont

		recthelper.setSize(var_14_1.transform, var_0_1, var_0_2)
		recthelper.setSize(var_14_0.go.transform, var_0_1, var_0_2)

		arg_14_0._questEditItemTab[arg_14_2] = var_14_0
	end

	var_14_0.questId = arg_14_3

	return var_14_0
end

function var_0_0.onClose(arg_15_0)
	if arg_15_0.frameHandle then
		UpdateBeat:RemoveListener(arg_15_0.frameHandle)
	end

	arg_15_0.frameHandle = nil
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
