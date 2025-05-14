module("modules.logic.rouge.view.RougeScrollAudioView", package.seeall)

local var_0_0 = class("RougeScrollAudioView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._scrollviewPath = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._scrollview = gohelper.findChildScrollRect(arg_2_0.viewGO, arg_2_0._scrollviewPath or "#scroll_view")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_5_0._scrollview.gameObject)

	arg_5_0._drag:AddDragBeginListener(arg_5_0._onDragBegin, arg_5_0)
	arg_5_0._drag:AddDragEndListener(arg_5_0._onDragEnd, arg_5_0)

	arg_5_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_5_0._scrollview.gameObject)

	arg_5_0._touch:AddClickDownListener(arg_5_0._onClickDown, arg_5_0)

	arg_5_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_5_0._scrollview.gameObject, DungeonMapEpisodeAudio, arg_5_0._scrollview)
end

function var_0_0._onDragBegin(arg_6_0)
	arg_6_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEnd(arg_7_0)
	arg_7_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDown(arg_8_0)
	arg_8_0._audioScroll:onClickDown()
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	return
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0._drag then
		arg_12_0._drag:RemoveDragBeginListener()
		arg_12_0._drag:RemoveDragEndListener()

		arg_12_0._drag = nil
	end

	if arg_12_0._touch then
		arg_12_0._touch:RemoveClickDownListener()

		arg_12_0._touch = nil
	end
end

return var_0_0
