module("modules.logic.versionactivity2_5.autochess.view.AutoChessBadgeView", package.seeall)

local var_0_0 = class("AutoChessBadgeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollBadge = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_Badge")
	arg_1_0._goBadgeContent = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_Badge/viewport/#go_BadgeContent")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._scrollBadgeGo = arg_4_0._scrollBadge.gameObject
	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._scrollBadgeGo)

	arg_4_0._drag:AddDragBeginListener(arg_4_0._onDragBeginHandler, arg_4_0)
	arg_4_0._drag:AddDragEndListener(arg_4_0._onDragEndHandler, arg_4_0)

	arg_4_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_4_0._scrollBadgeGo)

	arg_4_0._touch:AddClickDownListener(arg_4_0._onClickDownHandler, arg_4_0)

	arg_4_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_4_0._scrollBadgeGo, DungeonMapEpisodeAudio, arg_4_0._scrollBadge)
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)

	arg_5_0.actId = Activity182Model.instance:getCurActId()
	arg_5_0.actMo = Activity182Model.instance:getActMo()
	arg_5_0.rankCoList = {}

	local var_5_0 = lua_auto_chess_rank.configDict[arg_5_0.actId]

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_1.isShow then
			arg_5_0.rankCoList[#arg_5_0.rankCoList + 1] = iter_5_1
		end
	end

	arg_5_0.curIndex = 0

	arg_5_0:delayInit()
	TaskDispatcher.runRepeat(arg_5_0.delayInit, arg_5_0, 0.1)
end

function var_0_0.delayInit(arg_6_0)
	arg_6_0.curIndex = arg_6_0.curIndex + 1

	local var_6_0 = arg_6_0.rankCoList[arg_6_0.curIndex]
	local var_6_1 = arg_6_0:getResInst(AutoChessStrEnum.ResPath.BadgeItem, arg_6_0._goBadgeContent)

	MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, AutoChessBadgeItem):setData(var_6_0.rankId, arg_6_0.actMo.score, AutoChessBadgeItem.ShowType.BadgeView)

	if arg_6_0.curIndex >= #arg_6_0.rankCoList then
		TaskDispatcher.cancelTask(arg_6_0.delayInit, arg_6_0)
	end
end

function var_0_0.onDestroyView(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.delayInit, arg_7_0)

	if arg_7_0._drag then
		arg_7_0._drag:RemoveDragBeginListener()
		arg_7_0._drag:RemoveDragEndListener()

		arg_7_0._drag = nil
	end

	if arg_7_0._touch then
		arg_7_0._touch:RemoveClickDownListener()

		arg_7_0._touch = nil
	end
end

function var_0_0._onDragBeginHandler(arg_8_0)
	arg_8_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_9_0)
	arg_9_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_10_0)
	arg_10_0._audioScroll:onClickDown()
end

return var_0_0
