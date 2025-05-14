module("modules.logic.rouge.dlc.101.view.RougeLimiterDebuffOverView", package.seeall)

local var_0_0 = class("RougeLimiterDebuffOverView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollviews = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_views")
	arg_1_0._godebuffitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem")
	arg_1_0._imagedebufficon = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#image_debufficon")
	arg_1_0._txtbufflevel = gohelper.findChildText(arg_1_0.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#txt_bufflevel")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#txt_dec")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#txt_name")

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
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:initScroll()
end

function var_0_0.initScroll(arg_7_0)
	if not arg_7_0._scrollView then
		local var_7_0 = ListScrollParam.New()

		var_7_0.scrollGOPath = "#scroll_views"
		var_7_0.prefabType = ScrollEnum.ScrollPrefabFromView
		var_7_0.prefabUrl = "#scroll_views/Viewport/Content/#go_debuffitem"
		var_7_0.cellClass = RougeLimiterDebuffOverListItem
		var_7_0.scrollDir = ScrollEnum.ScrollDirV
		var_7_0.lineCount = 2
		var_7_0.cellWidth = 756
		var_7_0.cellHeight = 200
		arg_7_0._scrollView = LuaListScrollView.New(RougeLimiterDebuffOverListModel.instance, var_7_0)

		arg_7_0:addChildView(arg_7_0._scrollView)
	end

	local var_7_1 = arg_7_0.viewParam and arg_7_0.viewParam.limiterIds

	RougeLimiterDebuffOverListModel.instance:onInit(var_7_1)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
