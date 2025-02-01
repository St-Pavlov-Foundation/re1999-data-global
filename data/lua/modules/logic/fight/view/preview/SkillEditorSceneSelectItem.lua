module("modules.logic.fight.view.preview.SkillEditorSceneSelectItem", package.seeall)

slot0 = class("SkillEditorSceneSelectItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._text = gohelper.findChildText(slot1, "Text")
	slot0._text1 = gohelper.findChildText(slot1, "imgSelect/Text")
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot1)
	slot0._selectGO = gohelper.findChild(slot1, "imgSelect")
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._text.text = (lua_scene.configDict[slot1.co.sceneId] and slot3.name .. "\n" or "") .. slot2.id
	slot0._text1.text = (slot3 and slot3.name .. "\n" or "") .. slot2.id
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._selectGO, slot1)
end

function slot0._onClickThis(slot0)
	if GameSceneMgr.instance:getScene(SceneType.Fight).level:getCurLevelId() ~= slot0._mo.co.id then
		SkillEditorSceneSelectModel.instance:selectCell(SkillEditorSceneSelectModel.instance:getIndex(slot0._mo), true)
		GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevel(slot2)
		SkillEditorMgr.instance:setSceneLevelId(slot2)
		slot0:_setCameraOffset(slot2)
		FightController.instance:dispatchEvent(FightEvent.OnSkillEditorSceneChange)
	end
end

function slot0._setCameraOffset(slot0, slot1)
	slot4 = lua_scene_level.configDict[slot1] and slot3.cameraOffset
	slot5 = nil
	CameraMgr.instance:getVirtualCameraGO().transform.localPosition = (not string.nilorempty(slot4) or Vector3.zero) and Vector3.New(unpack(cjson.decode(slot4)))
end

return slot0
