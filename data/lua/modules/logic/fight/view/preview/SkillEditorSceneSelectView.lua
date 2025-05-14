module("modules.logic.fight.view.preview.SkillEditorSceneSelectView", package.seeall)

local var_0_0 = class("SkillEditorSceneSelectView", BaseView)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btnSelectScene = SLFramework.UGUI.UIClickListener.GetWithPath(arg_2_0.viewGO, "scene/Grid/imgScene")
	arg_2_0._sceneViewGO = gohelper.findChild(arg_2_0.viewGO, "selectScene")

	gohelper.setActive(arg_2_0._itemGOPrefab, false)

	arg_2_0._inp = gohelper.findChildTextMeshInputField(arg_2_0.viewGO, "selectScene/inp")
	arg_2_0._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectScene/btnClose")
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnSelectScene:AddClickListener(arg_3_0._showThis, arg_3_0)
	arg_3_0._btnClose:AddClickListener(arg_3_0._hideThis, arg_3_0)
	arg_3_0._inp:AddOnValueChanged(arg_3_0._onInpValueChanged, arg_3_0)
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._sceneViewGO):AddClickListener(arg_3_0._hideThis, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnSelectScene:RemoveClickListener()
	arg_4_0._btnClose:RemoveClickListener()
	arg_4_0._inp:RemoveOnValueChanged()
	SLFramework.UGUI.UIClickListener.Get(arg_4_0._sceneViewGO):RemoveClickListener()
end

function var_0_0._showThis(arg_5_0)
	gohelper.setActive(arg_5_0._sceneViewGO, true)
	arg_5_0:_updateItems()
	arg_5_0:_updateItemSelect()
end

function var_0_0._hideThis(arg_6_0)
	gohelper.setActive(arg_6_0._sceneViewGO, false)
end

function var_0_0._onInpValueChanged(arg_7_0, arg_7_1)
	arg_7_0:_updateItems()
	arg_7_0:_updateItemSelect()
end

function var_0_0._updateItems(arg_8_0)
	SkillEditorSceneSelectModel.instance:setSelect(arg_8_0._inp:GetText())
end

function var_0_0._updateItemSelect(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or GameSceneMgr.instance:getScene(SceneType.Fight).level:getCurLevelId()

	local var_9_0 = SkillEditorSceneSelectModel.instance:getList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1.co.id == arg_9_1 then
			SkillEditorSceneSelectModel.instance:selectCell(iter_9_0, true)
		end
	end
end

return var_0_0
