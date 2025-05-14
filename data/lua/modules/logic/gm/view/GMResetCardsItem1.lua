module("modules.logic.gm.view.GMResetCardsItem1", package.seeall)

local var_0_0 = class("GMResetCardsItem1", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._mo = nil
	arg_1_0._itemClick = SLFramework.UGUI.UIClickListener.Get(arg_1_1)

	arg_1_0._itemClick:AddClickListener(arg_1_0._onClickItem, arg_1_0)

	arg_1_0._canvasGroup = gohelper.onceAddComponent(arg_1_1, gohelper.Type_CanvasGroup)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	if not arg_2_0._cardItem then
		local var_2_0 = arg_2_0._view.viewContainer

		arg_2_0._cardGO = var_2_0:getResInst(var_2_0:getSetting().otherRes[1], gohelper.findChild(arg_2_0.go, "card"), "card")
		arg_2_0._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._cardGO, FightViewCardItem)

		gohelper.setActive(gohelper.findChild(arg_2_0._cardItem.go, "Image"), true)
		gohelper.setActive(arg_2_0._cardItem._txt, true)
		transformhelper.transformhelper.setLocalScale(arg_2_0._cardGO.transform, 0.8, 0.8, 0.8)
	end

	arg_2_0._mo = arg_2_1

	local var_2_1 = arg_2_1.newEntityId or arg_2_1.oldEntityId
	local var_2_2 = arg_2_1.newSkillId or arg_2_1.oldSkillId

	arg_2_0._cardItem:updateItem(var_2_1, var_2_2)

	arg_2_0._canvasGroup.alpha = arg_2_1.newSkillId and 1 or 0.5

	local var_2_3 = lua_skill.configDict[var_2_2]

	arg_2_0._cardItem._txt.text = var_2_3 and var_2_3.name or "nil"
end

function var_0_0._onClickItem(arg_3_0)
	arg_3_0._mo.newSkillId = nil
	arg_3_0._mo.newEntityId = nil
	arg_3_0._canvasGroup.alpha = 0.5

	GMResetCardsModel.instance:getModel1():onModelUpdate()
end

function var_0_0.onDestroy(arg_4_0)
	if arg_4_0._itemClick then
		arg_4_0._itemClick:RemoveClickListener()

		arg_4_0._itemClick = nil
	end
end

return var_0_0
