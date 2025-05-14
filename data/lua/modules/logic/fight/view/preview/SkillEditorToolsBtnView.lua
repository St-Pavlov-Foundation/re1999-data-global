module("modules.logic.fight.view.preview.SkillEditorToolsBtnView", package.seeall)

local var_0_0 = class("SkillEditorToolsBtnView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntools = gohelper.findChildButton(arg_1_0.viewGO, "right/btn_tools")
	arg_1_0._toolsBtnList = gohelper.findChild(arg_1_0.viewGO, "right/go_tool_btn_list")
	arg_1_0._btnModel = gohelper.findChildButton(arg_1_0.viewGO, "right/go_tool_btn_list/btn_model")
	arg_1_0._gotoolroot = gohelper.findChild(arg_1_0.viewGO, "go_tool_root")
	arg_1_0._gotoolviewmodel = gohelper.findChild(arg_1_0.viewGO, "go_tool_root/go_tool_view_model")
	arg_1_0._btnText = gohelper.findChildText(arg_1_0.viewGO, "right/btn_tools/Text")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntools:AddClickListener(arg_2_0._onBtnTools, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntools:RemoveClickListener()

	if arg_3_0._btns then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._btns) do
			iter_3_1:RemoveClickListener()
		end

		arg_3_0._btns = nil
	end
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addToolBtn("改伤害", arg_4_0._onClickDamage)
	arg_4_0:addToolBtn("角色描边", arg_4_0._onClickOutline)
	arg_4_0:addToolBtn("开启出牌镜头", arg_4_0._onClickPlayCardCameraAni)
	arg_4_0:addToolBtn("移除术阵特效", arg_4_0._onClickSuZhenSwitch)
end

function var_0_0._onClickDamage(arg_5_0)
	local var_5_0 = CommonInputMO.New()

	var_5_0.title = "请输入伤害数值"

	local var_5_1 = SkillEditorStepBuilder.customDamage
	local var_5_2 = SkillEditorStepBuilder.defaultDamage

	var_5_0.defaultInput = var_5_1 and var_5_1 > 0 and var_5_1 or var_5_2

	function var_5_0.sureCallback(arg_6_0)
		GameFacade.closeInputBox()

		local var_6_0 = tonumber(arg_6_0)

		if var_6_0 and var_6_0 > 0 then
			GameFacade.showToast(ToastEnum.IconId, "伤害调整为 " .. arg_6_0)

			SkillEditorStepBuilder.customDamage = var_6_0
		elseif string.nilorempty(arg_6_0) then
			SkillEditorStepBuilder.customDamage = nil
		end
	end

	GameFacade.openInputBox(var_5_0)
end

function var_0_0._onClickOutline(arg_7_0)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnClickOutline)
end

function var_0_0._onClickPlayCardCameraAni(arg_8_0, arg_8_1)
	arg_8_0._playCardCameraAniPlaying = not arg_8_0._playCardCameraAniPlaying
	arg_8_1.text = arg_8_0._playCardCameraAniPlaying and "关闭出牌镜头" or "开启出牌镜头"

	FightController.instance:dispatchEvent(FightEvent.SkillEditorPlayCardCameraAni, arg_8_0._playCardCameraAniPlaying)
end

function var_0_0._onClickSuZhenSwitch(arg_9_0)
	local var_9_0 = FightModel.instance:getMagicCircleInfo()

	if var_9_0 then
		local var_9_1 = FightHelper.getEntity(FightEntityScene.MySideId)

		if var_9_1 then
			local var_9_2 = lua_magic_circle.configDict[var_9_0.magicCircleId]

			if var_9_2 then
				var_9_1.effect:removeEffectByEffectName(var_9_2.loopEffect)
			end
		end
	end
end

function var_0_0.addToolBtn(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.cloneInPlace(arg_10_0._btnModel.gameObject, arg_10_1)

	gohelper.setActive(var_10_0, true)

	local var_10_1 = gohelper.getClick(var_10_0)
	local var_10_2 = gohelper.findChildText(var_10_0, "Text")

	var_10_1:AddClickListener(arg_10_2, arg_10_3 or arg_10_0, var_10_2)

	var_10_2.text = arg_10_1
	arg_10_0._btns = arg_10_0._btns or {}

	table.insert(arg_10_0._btns, var_10_1)

	return var_10_0
end

function var_0_0.addToolViewObj(arg_11_0, arg_11_1)
	return (gohelper.cloneInPlace(arg_11_0._gotoolviewmodel, arg_11_1))
end

function var_0_0.onRefreshViewParam(arg_12_0)
	return
end

function var_0_0._onBtnTools(arg_13_0)
	arg_13_0._listState = not arg_13_0._listState

	gohelper.setActive(arg_13_0._toolsBtnList, arg_13_0._listState)

	arg_13_0._btnText.text = arg_13_0._listState and "close" or "tools"

	local var_13_0 = arg_13_0._gotoolroot.transform.childCount

	for iter_13_0 = 0, var_13_0 - 1 do
		local var_13_1 = arg_13_0._gotoolroot.transform:GetChild(iter_13_0).gameObject

		gohelper.setActive(var_13_1, false)
	end
end

function var_0_0.hideToolsBtnList(arg_14_0)
	gohelper.setActive(arg_14_0._toolsBtnList, false)
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._listState = true

	arg_15_0:_onBtnTools()
	arg_15_0:openSubView(SkillEditorToolsChangeVariant, arg_15_0.viewGO)
	arg_15_0:openSubView(SkillEditorToolsChangeQuality, arg_15_0.viewGO)
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
