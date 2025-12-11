module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameViewDragItemBase", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_GameViewDragItemBase", RougeSimpleItemBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0.onDestroyView(arg_2_0)
	GameUtil.onDestroyViewMember(arg_2_0, "_drag")
	var_0_0.super.onDestroyView(arg_2_0)
end

function var_0_0.initDragObj(arg_3_0, arg_3_1)
	arg_3_0._drag = UIDragListenerHelper.New()

	arg_3_0._drag:create(arg_3_1, arg_3_0)
	arg_3_0._drag:registerCallback(arg_3_0._drag.EventBegin, arg_3_0._onBeginDrag, arg_3_0)
	arg_3_0._drag:registerCallback(arg_3_0._drag.EventDragging, arg_3_0._onDragging, arg_3_0)
	arg_3_0._drag:registerCallback(arg_3_0._drag.EventEnd, arg_3_0._onEndDrag, arg_3_0)
end

function var_0_0._dragContext(arg_4_0)
	return arg_4_0:baseViewContainer():dragContext()
end

function var_0_0.isCompleted(arg_5_0)
	return arg_5_0:_dragContext():isCompleted()
end

function var_0_0._onBeginDrag(arg_6_0, arg_6_1)
	assert(false, "please override this function")
end

function var_0_0._onDragging(arg_7_0, arg_7_1)
	assert(false, "please override this function")
end

function var_0_0._onEndDrag(arg_8_0, arg_8_1)
	assert(false, "please override this function")
end

function var_0_0.getDraggingSpriteAndZRot(arg_9_0)
	assert(false, "please override this function")
end

function var_0_0.isDraggable(arg_10_0)
	return true
end

return var_0_0
