module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapFinishElement", package.seeall)

local var_0_0 = class("VersionActivityFixedDungeonMapFinishElement", DungeonMapFinishElement)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._transform = arg_1_1.transform

	local var_1_0 = string.splitToNumber(arg_1_0._config.pos, "#")

	transformhelper.setLocalPos(arg_1_0._transform, var_1_0[1] or 0, var_1_0[2] or 0, var_1_0[3] or 0)

	arg_1_0.resPath = arg_1_0._config.res
	arg_1_0.effectPath = arg_1_0._config.effect

	if arg_1_0._existGo then
		if not string.nilorempty(arg_1_0.resPath) then
			arg_1_0._itemGo = gohelper.findChild(arg_1_0._go, arg_1_0:getPathName(arg_1_0.resPath) .. "(Clone)")

			DungeonMapFinishElement.addBoxColliderListener(arg_1_0._itemGo, arg_1_0._onDown, arg_1_0)
		end

		if not string.nilorempty(arg_1_0.effectPath) then
			arg_1_0._effectGo = gohelper.findChild(arg_1_0._go, arg_1_0:getPathName(arg_1_0.effectPath) .. "(Clone)")

			DungeonMapFinishElement.addBoxColliderListener(arg_1_0._effectGo, arg_1_0._onDown, arg_1_0)
		end
	else
		if arg_1_0._resLoader then
			return
		end

		arg_1_0._resLoader = MultiAbLoader.New()

		if not string.nilorempty(arg_1_0.resPath) then
			arg_1_0._resLoader:addPath(arg_1_0.resPath)
		end

		if not string.nilorempty(arg_1_0.effectPath) then
			arg_1_0._resLoader:addPath(arg_1_0.effectPath)
		end

		arg_1_0._resLoader:startLoad(arg_1_0._onResLoaded, arg_1_0)
	end
end

function var_0_0._onResLoaded(arg_2_0)
	if not string.nilorempty(arg_2_0.resPath) then
		local var_2_0 = arg_2_0._resLoader:getAssetItem(arg_2_0.resPath):GetResource(arg_2_0.resPath)

		arg_2_0._itemGo = gohelper.clone(var_2_0, arg_2_0._go)

		local var_2_1 = arg_2_0._config.resScale

		if var_2_1 and var_2_1 ~= 0 then
			transformhelper.setLocalScale(arg_2_0._itemGo.transform, var_2_1, var_2_1, 1)
		end

		gohelper.setLayer(arg_2_0._itemGo, UnityLayer.Scene, true)
		DungeonMapFinishElement.addBoxColliderListener(arg_2_0._itemGo, arg_2_0._onDown, arg_2_0)
		transformhelper.setLocalPos(arg_2_0._itemGo.transform, 0, 0, -1)
	end

	if not string.nilorempty(arg_2_0.effectPath) then
		local var_2_2 = string.splitToNumber(arg_2_0._config.tipOffsetPos, "#")

		arg_2_0._offsetX = var_2_2[1] or 0
		arg_2_0._offsetY = var_2_2[2] or 0

		local var_2_3 = arg_2_0._resLoader:getAssetItem(arg_2_0.effectPath):GetResource(arg_2_0.effectPath)

		arg_2_0._effectGo = gohelper.clone(var_2_3, arg_2_0._go)

		DungeonMapFinishElement.addBoxColliderListener(arg_2_0._effectGo, arg_2_0._onDown, arg_2_0)
		transformhelper.setLocalPos(arg_2_0._effectGo.transform, arg_2_0._offsetX, arg_2_0._offsetY, -3)

		local var_2_4 = gohelper.findChild(arg_2_0._effectGo, "ani/yuanjian_new_07/gou")

		if var_2_4 then
			gohelper.setActive(var_2_4, true)
			var_2_4:GetComponent(typeof(UnityEngine.Animator)):Play("idle")
		end
	end
end

function var_0_0.onDown(arg_3_0)
	arg_3_0:_onDown()
end

function var_0_0._onDown(arg_4_0)
	arg_4_0._sceneElements:setMouseElementDown(arg_4_0)
end

function var_0_0.onClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if arg_5_0._config.type == DungeonEnum.ElementType.None and arg_5_0._config.fragment > 0 then
		ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
			notShowToast = true,
			fragmentId = arg_5_0._config.fragment,
			elementId = arg_5_0._config.id
		})
	end
end

return var_0_0
