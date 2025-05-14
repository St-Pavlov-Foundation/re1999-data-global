module("modules.logic.versionactivity1_5.sportsnews.controller.SportsNewsController", package.seeall)

local var_0_0 = class("SportsNewsController", BaseController)

function var_0_0.openSportsNewsMainView(arg_1_0, arg_1_1)
	SportsNewsModel.instance:setJumpToOrderId(nil)

	arg_1_1 = arg_1_1 or VersionActivity1_5Enum.ActivityId.SportsNews

	ViewMgr.instance:openView(ViewName.SportsNewsView, {
		formToMain = true,
		actId = arg_1_1
	})
end

var_0_0.UI_CLICK_BLOCK_KEY = "SportsNewsBlock"

function var_0_0.startBlock(arg_2_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0.endBlock(arg_3_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.cantJumpDungeonGetName(arg_4_0, arg_4_1)
	local var_4_0 = JumpConfig.instance:getJumpConfig(arg_4_1)

	if not var_4_0 then
		return false
	end

	local var_4_1 = var_4_0.param
	local var_4_2, var_4_3 = JumpController.instance:canJumpNew(var_4_1)

	if var_4_2 then
		return true
	end

	local var_4_4 = string.split(var_4_1, "#")
	local var_4_5 = tonumber(var_4_4[#var_4_4])
	local var_4_6 = DungeonConfig.instance:getEpisodeCO(var_4_5)

	if var_4_6 then
		local var_4_7 = DungeonController.getEpisodeName(var_4_6)

		return false, ToastEnum.V1a5SportNewsOrderJumpTo, var_4_7, var_4_6.name
	end

	return false, var_4_3
end

function var_0_0.jumpToFinishTask(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0, var_5_1, var_5_2, var_5_3 = arg_5_0:cantJumpDungeonGetName(arg_5_1.cfg.jumpId)

	if not var_5_0 then
		GameFacade.showToast(var_5_1, var_5_2, var_5_3)
	else
		local var_5_4 = {
			luaLang("p_versionactivity_1_5_enterview_txt_Activity2"),
			arg_5_1.cfg.name
		}
		local var_5_5 = {
			special = true,
			desc = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a5_news_order_return_view"), var_5_4),
			checkFunc = arg_5_1.canFinish,
			checkFuncObj = arg_5_1,
			openedViewNameList = JumpController.instance:getCurrentOpenedView()
		}

		SportsNewsModel.instance:setJumpToOrderId(arg_5_1.cfg.id)
		JumpController.instance:jump(arg_5_1.cfg.jumpId, arg_5_2, arg_5_3, var_5_5)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
