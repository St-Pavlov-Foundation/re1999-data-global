module("modules.logic.login.controller.work.LoginPreLoadWork", package.seeall)

local var_0_0 = class("LoginPreLoadWork", BaseWork)
local var_0_1 = {
	"ui/viewres/scene/loadingview.prefab",
	"ui/viewres/scene/loadingblackview.prefab",
	"ui/viewres/scene/loadingheadsetview.prefab"
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	if not arg_1_0._loader then
		UIBlockMgr.instance:startBlock(UIBlockKey.Loading)

		arg_1_0._loader = MultiAbLoader.New()

		arg_1_0._loader:setPathList(var_0_1)
		arg_1_0._loader:startLoad(arg_1_0._onLoaded, arg_1_0)
	else
		arg_1_0:_done()
	end
end

function var_0_0._onLoaded(arg_2_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.Loading)
	arg_2_0:_done()
end

function var_0_0._isFirstGuide(arg_3_0)
	return not (GuideModel.instance:isGuideFinish(101) or GuideController.instance:isForbidGuides())
end

function var_0_0._done(arg_4_0)
	local var_4_0 = gohelper.find("UIRoot/OriginBg")

	gohelper.setActive(var_4_0, false)
	ViewMgr.instance:closeView(ViewName.LoginView)

	if arg_4_0:_isFirstGuide() then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingHeadsetView)
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
	arg_4_0:onDone(true)
end

return var_0_0
