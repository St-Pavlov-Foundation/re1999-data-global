module("modules.logic.fight.view.preview.SkillEditorToolsChangeVariant", package.seeall)

local var_0_0 = class("SkillEditorToolsChangeVariant", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
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

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0._onBtnClick(arg_6_0)
	arg_6_0:getParentView():hideToolsBtnList()
	gohelper.setActive(arg_6_0._btn, true)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:getParentView():addToolBtn("换变体", arg_7_0._onBtnClick, arg_7_0)

	arg_7_0._btn = arg_7_0:getParentView():addToolViewObj("换变体")
	arg_7_0._item = gohelper.findChild(arg_7_0._btn, "variant")

	arg_7_0:_showData()
end

function var_0_0._showData(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(FightVariantHeartComp.VariantKey) do
		table.insert(var_8_0, iter_8_0)
	end

	table.insert(var_8_0, 1, -1)
	arg_8_0:com_createObjList(arg_8_0._onItemShow, var_8_0, arg_8_0._btn, arg_8_0._item)
end

function var_0_0._onItemShow(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = gohelper.findChildText(arg_9_1, "Text")

	var_9_0.text = arg_9_2

	if arg_9_2 == -1 then
		var_9_0.text = "还原"
	end

	local var_9_1 = gohelper.getClick(arg_9_1)

	arg_9_0:addClickCb(var_9_1, arg_9_0._onItemClick, arg_9_0, arg_9_2)
end

function var_0_0._onItemClick(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_1 = GameSceneMgr.instance:getCurScene().entityMgr

	if SkillEditorMgr.instance.cur_select_entity_id then
		var_10_0 = var_10_1:getEntity(SkillEditorMgr.instance.cur_select_entity_id)
	else
		var_10_0 = var_10_1:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])
	end

	if var_10_0.variantHeart then
		for iter_10_0, iter_10_1 in pairs(FightVariantHeartComp.VariantKey) do
			if arg_10_1 ~= iter_10_0 then
				local var_10_2 = var_10_0.spineRenderer:getReplaceMat()

				if not var_10_2 then
					return
				end

				var_10_2:DisableKeyword(iter_10_1)
			end
		end

		if arg_10_1 == -1 then
			return
		end

		var_10_0.variantHeart:_changeVariant(arg_10_1)
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
