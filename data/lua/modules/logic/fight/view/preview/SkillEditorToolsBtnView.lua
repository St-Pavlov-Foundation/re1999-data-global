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
	arg_4_0:addToolBtn("诺蒂卡衔接测试", arg_4_0._onClickNuoDiKaXianJie)
end

function var_0_0._onClickNuoDiKaXianJie(arg_5_0)
	ViewMgr.instance:openView(ViewName.GMFightNuoDiKaXianJieCeShi)
end

function var_0_0._onClickDamage(arg_6_0)
	local var_6_0 = CommonInputMO.New()

	var_6_0.title = "请输入伤害数值"

	local var_6_1 = SkillEditorStepBuilder.customDamage
	local var_6_2 = SkillEditorStepBuilder.defaultDamage

	var_6_0.defaultInput = var_6_1 and var_6_1 > 0 and var_6_1 or var_6_2

	function var_6_0.sureCallback(arg_7_0)
		GameFacade.closeInputBox()

		local var_7_0 = tonumber(arg_7_0)

		if var_7_0 and var_7_0 > 0 then
			GameFacade.showToast(ToastEnum.IconId, "伤害调整为 " .. arg_7_0)

			SkillEditorStepBuilder.customDamage = var_7_0
		elseif string.nilorempty(arg_7_0) then
			SkillEditorStepBuilder.customDamage = nil
		end
	end

	GameFacade.openInputBox(var_6_0)
end

function var_0_0._onClickOutline(arg_8_0)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnClickOutline)
end

function var_0_0._onClickPlayCardCameraAni(arg_9_0, arg_9_1)
	arg_9_0._playCardCameraAniPlaying = not arg_9_0._playCardCameraAniPlaying
	arg_9_1.text = arg_9_0._playCardCameraAniPlaying and "关闭出牌镜头" or "开启出牌镜头"

	FightController.instance:dispatchEvent(FightEvent.SkillEditorPlayCardCameraAni, arg_9_0._playCardCameraAniPlaying)
end

function var_0_0._onClickSuZhenSwitch(arg_10_0)
	local var_10_0 = FightModel.instance:getMagicCircleInfo()

	if var_10_0 then
		local var_10_1 = FightHelper.getEntity(FightEntityScene.MySideId)

		if var_10_1 then
			local var_10_2 = lua_magic_circle.configDict[var_10_0.magicCircleId]

			if var_10_2 then
				var_10_1.effect:removeEffectByEffectName(var_10_2.loopEffect)
			end
		end
	end
end

function var_0_0.addToolBtn(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.cloneInPlace(arg_11_0._btnModel.gameObject, arg_11_1)

	gohelper.setActive(var_11_0, true)

	local var_11_1 = gohelper.getClick(var_11_0)
	local var_11_2 = gohelper.findChildText(var_11_0, "Text")

	var_11_1:AddClickListener(arg_11_2, arg_11_3 or arg_11_0, var_11_2)

	var_11_2.text = arg_11_1
	arg_11_0._btns = arg_11_0._btns or {}

	table.insert(arg_11_0._btns, var_11_1)

	return var_11_0
end

function var_0_0.addToolViewObj(arg_12_0, arg_12_1)
	return (gohelper.cloneInPlace(arg_12_0._gotoolviewmodel, arg_12_1))
end

function var_0_0.onRefreshViewParam(arg_13_0)
	return
end

function var_0_0._onBtnTools(arg_14_0)
	arg_14_0._listState = not arg_14_0._listState

	gohelper.setActive(arg_14_0._toolsBtnList, arg_14_0._listState)

	arg_14_0._btnText.text = arg_14_0._listState and "close" or "tools"

	local var_14_0 = arg_14_0._gotoolroot.transform.childCount

	for iter_14_0 = 0, var_14_0 - 1 do
		local var_14_1 = arg_14_0._gotoolroot.transform:GetChild(iter_14_0).gameObject

		gohelper.setActive(var_14_1, false)
	end
end

function var_0_0.hideToolsBtnList(arg_15_0)
	gohelper.setActive(arg_15_0._toolsBtnList, false)
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0._listState = true

	arg_16_0:_onBtnTools()
	arg_16_0:openSubView(SkillEditorToolsChangeVariant, arg_16_0.viewGO)
	arg_16_0:openSubView(SkillEditorToolsChangeQuality, arg_16_0.viewGO)
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
