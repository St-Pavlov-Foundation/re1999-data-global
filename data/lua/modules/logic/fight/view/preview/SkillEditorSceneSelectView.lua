module("modules.logic.fight.view.preview.SkillEditorSceneSelectView", package.seeall)

slot0 = class("SkillEditorSceneSelectView", BaseView)

function slot0.ctor(slot0)
end

function slot0.onInitView(slot0)
	slot0._btnSelectScene = SLFramework.UGUI.UIClickListener.GetWithPath(slot0.viewGO, "scene/Grid/imgScene")
	slot0._sceneViewGO = gohelper.findChild(slot0.viewGO, "selectScene")

	gohelper.setActive(slot0._itemGOPrefab, false)

	slot0._inp = gohelper.findChildTextMeshInputField(slot0.viewGO, "selectScene/inp")
	slot0._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectScene/btnClose")
end

function slot0.addEvents(slot0)
	slot0._btnSelectScene:AddClickListener(slot0._showThis, slot0)
	slot0._btnClose:AddClickListener(slot0._hideThis, slot0)
	slot0._inp:AddOnValueChanged(slot0._onInpValueChanged, slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._sceneViewGO):AddClickListener(slot0._hideThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnSelectScene:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
	slot0._inp:RemoveOnValueChanged()
	SLFramework.UGUI.UIClickListener.Get(slot0._sceneViewGO):RemoveClickListener()
end

function slot0._showThis(slot0)
	gohelper.setActive(slot0._sceneViewGO, true)
	slot0:_updateItems()
	slot0:_updateItemSelect()
end

function slot0._hideThis(slot0)
	gohelper.setActive(slot0._sceneViewGO, false)
end

function slot0._onInpValueChanged(slot0, slot1)
	slot0:_updateItems()
	slot0:_updateItemSelect()
end

function slot0._updateItems(slot0)
	SkillEditorSceneSelectModel.instance:setSelect(slot0._inp:GetText())
end

function slot0._updateItemSelect(slot0, slot1)
	for slot6, slot7 in ipairs(SkillEditorSceneSelectModel.instance:getList()) do
		if slot7.co.id == (slot1 or GameSceneMgr.instance:getScene(SceneType.Fight).level:getCurLevelId()) then
			SkillEditorSceneSelectModel.instance:selectCell(slot6, true)
		end
	end
end

return slot0
