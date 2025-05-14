module("modules.logic.story.view.StoryActivityChapterBase", package.seeall)

local var_0_0 = class("StoryActivityChapterBase", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.rootGO = gohelper.create2d(arg_1_1, "chapter")

	local var_1_0 = arg_1_0.rootGO.transform

	var_1_0.anchorMin = RectTransformDefine.Anchor.LeftBottom
	var_1_0.anchorMax = RectTransformDefine.Anchor.RightUp
	var_1_0.sizeDelta = RectTransformDefine.Anchor.LeftBottom

	arg_1_0:onCtor()
end

function var_0_0.loadPrefab(arg_2_0)
	if not arg_2_0.assetPath then
		return
	end

	if not arg_2_0._resLoader then
		arg_2_0._resLoader = PrefabInstantiate.Create(arg_2_0.rootGO)
	end

	arg_2_0._resLoader:startLoad(arg_2_0.assetPath, arg_2_0.onLoaded, arg_2_0)
end

function var_0_0.onLoaded(arg_3_0)
	arg_3_0.viewGO = arg_3_0._resLoader:getInstGO()

	arg_3_0:onInitView()
	arg_3_0:onUpdateView()
end

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	if not arg_4_0.viewGO then
		arg_4_0:loadPrefab()

		return
	end

	gohelper.setActive(arg_4_0.rootGO, true)
	arg_4_0:onUpdateView()
end

function var_0_0.hide(arg_5_0)
	gohelper.setActive(arg_5_0.rootGO, false)
	arg_5_0:onHide()
end

function var_0_0.onCtor(arg_6_0)
	return
end

function var_0_0.onInitView(arg_7_0)
	return
end

function var_0_0.onUpdateView(arg_8_0)
	return
end

function var_0_0.onHide(arg_9_0)
	return
end

function var_0_0.onDestory(arg_10_0)
	if arg_10_0._resloader then
		arg_10_0._resloader:dispose()

		arg_10_0._resloader = nil
	end

	if arg_10_0.rootGO then
		gohelper.destroy(arg_10_0.rootGO)

		arg_10_0.rootGO = nil
	end

	arg_10_0:__onDispose()
end

return var_0_0
