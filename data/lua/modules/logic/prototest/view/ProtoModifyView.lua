module("modules.logic.prototest.view.ProtoModifyView", package.seeall)

local var_0_0 = class("ProtoModifyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnBack1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "paramlistpanel/btnBack")
	arg_1_0._btnBack2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "modifyparampanel/btnBack")
	arg_1_0._btnSave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "modifyparampanel/panel/Btn_save")
	arg_1_0._listPanel = gohelper.findChild(arg_1_0.viewGO, "paramlistpanel")
	arg_1_0._modifyPanel = gohelper.findChild(arg_1_0.viewGO, "modifyparampanel")
	arg_1_0._txtTitle1 = gohelper.findChildText(arg_1_0.viewGO, "paramlistpanel/txtTitle")
	arg_1_0._txtTitle2 = gohelper.findChildText(arg_1_0.viewGO, "modifyparampanel/txtTitle")
	arg_1_0._txtParam = gohelper.findChildText(arg_1_0.viewGO, "modifyparampanel/panel/txtParam")
	arg_1_0._inputValue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "modifyparampanel/panel/inputValue")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBack1:AddClickListener(arg_2_0._onClickBack, arg_2_0)
	arg_2_0._btnBack2:AddClickListener(arg_2_0._closeModify, arg_2_0)
	arg_2_0._btnSave:AddClickListener(arg_2_0._onClickSave, arg_2_0)
	ProtoTestMgr.instance:registerCallback(ProtoEnum.OnClickModifyItem, arg_2_0._enterModifyItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBack1:RemoveClickListener()
	arg_3_0._btnBack2:RemoveClickListener()
	arg_3_0._btnSave:RemoveClickListener()
	ProtoTestMgr.instance:unregisterCallback(ProtoEnum.OnClickModifyItem, arg_3_0._enterModifyItem, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.protoMO
	local var_4_1 = arg_4_0.viewParam.paramId

	if var_4_0 then
		ProtoModifyModel.instance:enterProto(var_4_0)

		if var_4_1 then
			arg_4_0:_enterModifyItem(var_4_1)
		else
			arg_4_0:_updateTitle()
		end
	end
end

function var_0_0._enterModifyItem(arg_5_0, arg_5_1)
	ProtoModifyModel.instance:enterParam(arg_5_1)

	local var_5_0 = ProtoModifyModel.instance:getLastMO()
	local var_5_1 = var_5_0:isRepeated()
	local var_5_2 = var_5_0:isProtoType()

	if var_5_1 or var_5_2 then
		gohelper.setActive(arg_5_0._listPanel, true)
		gohelper.setActive(arg_5_0._modifyPanel, false)
	else
		local var_5_3 = var_5_0.value

		var_5_3 = (type(var_5_3) == "boolean" or type(var_5_3) == "number") and tostring(var_5_3) or var_5_3

		arg_5_0._inputValue:SetText(var_5_3)
		gohelper.setActive(arg_5_0._listPanel, false)
		gohelper.setActive(arg_5_0._modifyPanel, true)
	end

	arg_5_0:_updateTitle()
end

function var_0_0._updateTitle(arg_6_0)
	local var_6_0 = ProtoModifyModel.instance:getProtoMO()
	local var_6_1 = ProtoModifyModel.instance:getDepthParamMOs()
	local var_6_2 = ProtoModifyModel.instance:getLastMO()
	local var_6_3 = var_6_0.struct

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if iter_6_1.repeated then
			var_6_3 = var_6_3 .. "[" .. iter_6_1.key .. "]"
		else
			var_6_3 = var_6_3 .. " - " .. iter_6_1.key
		end
	end

	arg_6_0._txtTitle1.text = var_6_3
	arg_6_0._txtTitle2.text = var_6_3

	if isTypeOf(var_6_2, ProtoTestCaseParamMO) then
		local var_6_4 = ProtoEnum.LabelType[var_6_2.pLabel]
		local var_6_5 = var_6_2.pType == ProtoEnum.ParamType.proto and var_6_2.struct or ProtoEnum.ParamType[var_6_2.pType]

		arg_6_0._txtParam.text = var_6_4 .. " - " .. var_6_5
	end
end

function var_0_0._updateList(arg_7_0)
	ProtoModifyModel.instance:onModelUpdate()
	ProtoTestCaseModel.instance:onModelUpdate()
end

function var_0_0._onClickBack(arg_8_0)
	if ProtoModifyModel.instance:isRoot() then
		arg_8_0:closeThis()
	else
		arg_8_0:_closeModify()
	end
end

function var_0_0._closeModify(arg_9_0)
	ProtoModifyModel.instance:exitParam()
	gohelper.setActive(arg_9_0._listPanel, true)
	gohelper.setActive(arg_9_0._modifyPanel, false)
	arg_9_0:_updateTitle()
end

function var_0_0._onClickSave(arg_10_0)
	local var_10_0 = ProtoModifyModel.instance:getLastMO()
	local var_10_1 = arg_10_0._inputValue:GetText()

	if var_10_0.pType ~= ProtoEnum.ParamType.string and string.nilorempty(var_10_1) and not var_10_0:isOptional() then
		GameFacade.showToast(ToastEnum.ProtoModifyNotString)

		return
	end

	if var_10_0.pType == ProtoEnum.ParamType.int32 or var_10_0.pType == ProtoEnum.ParamType.uint32 then
		local var_10_2 = tonumber(var_10_1)

		if not var_10_2 then
			GameFacade.showToast(ToastEnum.ProtoModifyNotValue)

			return
		end

		var_10_0.value = var_10_2
	elseif var_10_0.pType == ProtoEnum.ParamType.int64 or var_10_0.pType == ProtoEnum.ParamType.uint64 then
		if not string.nilorempty(var_10_1) and not tonumber(var_10_1) then
			GameFacade.showToast(ToastEnum.ProtoModifyNotValue)

			return
		end

		var_10_0.value = not string.nilorempty(var_10_1) and var_10_1 or nil
	elseif var_10_0.pType == ProtoEnum.ParamType.bool then
		local var_10_3 = ({
			["0"] = false,
			["false"] = false,
			["1"] = true,
			["true"] = true
		})[string.lower(var_10_1)]

		if not var_10_0:isOptional() and var_10_3 == nil then
			GameFacade.showToast(ToastEnum.ProtoModifyIsNil)

			return
		end

		var_10_0.value = var_10_3
	else
		var_10_0.value = var_10_1
	end

	arg_10_0:_closeModify()
	arg_10_0:_updateList()
end

function var_0_0.onClickModalMask(arg_11_0)
	if arg_11_0._modifyPanel.activeInHierarchy then
		arg_11_0:_closeModify()
	else
		arg_11_0:_onClickBack()
	end
end

return var_0_0
