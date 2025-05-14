module("modules.logic.fight.view.preview.SkillEditorSceneSelectItem", package.seeall)

local var_0_0 = class("SkillEditorSceneSelectItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._text = gohelper.findChildText(arg_1_1, "Text")
	arg_1_0._text1 = gohelper.findChildText(arg_1_1, "imgSelect/Text")
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_1)
	arg_1_0._selectGO = gohelper.findChild(arg_1_1, "imgSelect")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	local var_4_0 = arg_4_1.co
	local var_4_1 = lua_scene.configDict[var_4_0.sceneId]

	arg_4_0._text.text = (var_4_1 and var_4_1.name .. "\n" or "") .. var_4_0.id
	arg_4_0._text1.text = (var_4_1 and var_4_1.name .. "\n" or "") .. var_4_0.id
end

function var_0_0.onSelect(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._selectGO, arg_5_1)
end

function var_0_0._onClickThis(arg_6_0)
	local var_6_0 = GameSceneMgr.instance:getScene(SceneType.Fight).level:getCurLevelId()
	local var_6_1 = arg_6_0._mo.co.id

	if var_6_0 ~= var_6_1 then
		local var_6_2 = SkillEditorSceneSelectModel.instance:getIndex(arg_6_0._mo)

		SkillEditorSceneSelectModel.instance:selectCell(var_6_2, true)
		GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevel(var_6_1)
		SkillEditorMgr.instance:setSceneLevelId(var_6_1)
		arg_6_0:_setCameraOffset(var_6_1)
		FightController.instance:dispatchEvent(FightEvent.OnSkillEditorSceneChange)
	end
end

function var_0_0._setCameraOffset(arg_7_0, arg_7_1)
	local var_7_0 = CameraMgr.instance:getVirtualCameraGO()
	local var_7_1 = lua_scene_level.configDict[arg_7_1]
	local var_7_2 = var_7_1 and var_7_1.cameraOffset
	local var_7_3

	if string.nilorempty(var_7_2) then
		var_7_3 = Vector3.zero
	else
		var_7_3 = Vector3.New(unpack(cjson.decode(var_7_2)))
	end

	var_7_0.transform.localPosition = var_7_3
end

return var_0_0
