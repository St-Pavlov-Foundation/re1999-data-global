module("modules.logic.dungeon.view.map.DungeonMapFinishElement", package.seeall)

local var_0_0 = class("DungeonMapFinishElement", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._config = arg_1_1[1]
	arg_1_0._mapScene = arg_1_1[2]
	arg_1_0._sceneElements = arg_1_1[3]
	arg_1_0._existGo = arg_1_1[4]
end

function var_0_0.getElementId(arg_2_0)
	return arg_2_0._config.id
end

function var_0_0.hide(arg_3_0)
	gohelper.setActive(arg_3_0._go, false)
end

function var_0_0.show(arg_4_0)
	gohelper.setActive(arg_4_0._go, true)
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0._go = arg_5_1
	arg_5_0._transform = arg_5_1.transform

	local var_5_0 = string.splitToNumber(arg_5_0._config.pos, "#")

	transformhelper.setLocalPos(arg_5_0._transform, var_5_0[1] or 0, var_5_0[2] or 0, var_5_0[3] or 0)

	arg_5_0.resPath = arg_5_0._config.res
	arg_5_0.effectPath = arg_5_0._config.effect

	if arg_5_0._existGo then
		arg_5_0._itemGo = gohelper.findChild(arg_5_0._go, arg_5_0:getPathName(arg_5_0.resPath) .. "(Clone)")

		var_0_0.addBoxColliderListener(arg_5_0._itemGo, arg_5_0._onDown, arg_5_0)

		if not string.nilorempty(arg_5_0.effectPath) then
			arg_5_0._effectGo = gohelper.findChild(arg_5_0._go, arg_5_0:getPathName(arg_5_0.effectPath) .. "(Clone)")

			var_0_0.addBoxColliderListener(arg_5_0._effectGo, arg_5_0._onDown, arg_5_0)
		end
	else
		if arg_5_0._resLoader then
			return
		end

		arg_5_0._resLoader = MultiAbLoader.New()

		arg_5_0._resLoader:addPath(arg_5_0.resPath)

		if not string.nilorempty(arg_5_0.effectPath) then
			arg_5_0._resLoader:addPath(arg_5_0.effectPath)
		end

		arg_5_0._resLoader:startLoad(arg_5_0._onResLoaded, arg_5_0)
	end
end

function var_0_0._onResLoaded(arg_6_0)
	local var_6_0 = arg_6_0._resLoader:getAssetItem(arg_6_0.resPath):GetResource(arg_6_0.resPath)

	arg_6_0._itemGo = gohelper.clone(var_6_0, arg_6_0._go)

	local var_6_1 = arg_6_0._config.resScale

	if var_6_1 and var_6_1 ~= 0 then
		transformhelper.setLocalScale(arg_6_0._itemGo.transform, var_6_1, var_6_1, 1)
	end

	gohelper.setLayer(arg_6_0._itemGo, UnityLayer.Scene, true)
	var_0_0.addBoxColliderListener(arg_6_0._itemGo, arg_6_0._onDown, arg_6_0)
	transformhelper.setLocalPos(arg_6_0._itemGo.transform, 0, 0, -1)

	if not string.nilorempty(arg_6_0.effectPath) then
		local var_6_2 = string.splitToNumber(arg_6_0._config.tipOffsetPos, "#")

		arg_6_0._offsetX = var_6_2[1] or 0
		arg_6_0._offsetY = var_6_2[2] or 0

		local var_6_3 = arg_6_0._resLoader:getAssetItem(arg_6_0.effectPath):GetResource(arg_6_0.effectPath)

		arg_6_0._effectGo = gohelper.clone(var_6_3, arg_6_0._go)

		var_0_0.addBoxColliderListener(arg_6_0._effectGo, arg_6_0._onDown, arg_6_0)
		transformhelper.setLocalPos(arg_6_0._effectGo.transform, arg_6_0._offsetX, arg_6_0._offsetY, -3)

		local var_6_4 = gohelper.findChild(arg_6_0._effectGo, "ani/yuanjian_new_07/gou")

		if var_6_4 then
			gohelper.setActive(var_6_4, true)
			var_6_4:GetComponent(typeof(UnityEngine.Animator)):Play("idle")
		end
	end
end

function var_0_0.onDown(arg_7_0)
	arg_7_0:_onDown()
end

function var_0_0._onDown(arg_8_0)
	arg_8_0._sceneElements:setElementDown(arg_8_0)
end

function var_0_0.onClick(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if arg_9_0._config.type == DungeonEnum.ElementType.PuzzleGame then
		ViewMgr.instance:openView(ViewName.VersionActivityPuzzleView, {
			isFinish = true,
			elementCo = arg_9_0._config
		})

		return
	end

	local var_9_0 = lua_chapter_map_fragment.configDict[arg_9_0._config.fragment]

	if var_9_0 and var_9_0.type == DungeonEnum.FragmentType.LeiMiTeBeiNew then
		ViewMgr.instance:openView(ViewName.VersionActivityNewsView, {
			fragmentId = var_9_0.id
		})
	end
end

function var_0_0._onSetEpisodeListVisible(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._go, arg_10_1)
end

function var_0_0.addEventListeners(arg_11_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnSetEpisodeListVisible, arg_11_0._onSetEpisodeListVisible, arg_11_0)
end

function var_0_0.removeEventListeners(arg_12_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnSetEpisodeListVisible, arg_12_0._onSetEpisodeListVisible, arg_12_0)
end

function var_0_0.addBoxCollider2D(arg_13_0)
	local var_13_0 = ZProj.BoxColliderClickListener.Get(arg_13_0)
	local var_13_1 = gohelper.onceAddComponent(arg_13_0, typeof(UnityEngine.BoxCollider2D))

	var_13_1.enabled = true
	var_13_1.size = Vector2(1.5, 1.5)

	var_13_0:SetIgnoreUI(true)

	return var_13_0
end

function var_0_0.addBoxColliderListener(arg_14_0, arg_14_1, arg_14_2)
	var_0_0.addBoxCollider2D(arg_14_0):AddClickListener(arg_14_1, arg_14_2)
end

function var_0_0.isValid(arg_15_0)
	return not gohelper.isNil(arg_15_0._go)
end

function var_0_0.onDestroy(arg_16_0)
	gohelper.setActive(arg_16_0._go, true)

	if arg_16_0._effectGo then
		gohelper.destroy(arg_16_0._effectGo)

		arg_16_0._effectGo = nil
	end

	if arg_16_0._itemGo then
		gohelper.destroy(arg_16_0._itemGo)

		arg_16_0._itemGo = nil
	end

	if arg_16_0._go then
		gohelper.destroy(arg_16_0._go)

		arg_16_0._go = nil
	end

	if arg_16_0._resLoader then
		arg_16_0._resLoader:dispose()

		arg_16_0._resLoader = nil
	end
end

function var_0_0.getPathName(arg_17_0, arg_17_1)
	arg_17_1 = string.split(arg_17_1, ".")[1]

	local var_17_0 = string.split(arg_17_1, "/")

	return var_17_0[#var_17_0]
end

return var_0_0
