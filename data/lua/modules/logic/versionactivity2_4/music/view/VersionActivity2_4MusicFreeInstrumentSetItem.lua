module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeInstrumentSetItem", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeInstrumentSetItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnroot = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_root")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#btn_root/#go_select")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.viewGO, "#btn_root/#go_unselect")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#btn_root/#image_icon")
	arg_1_0._imageselectframe = gohelper.findChildImage(arg_1_0.viewGO, "#btn_root/#image_selectframe")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_root/#btn_click")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnroot:AddClickListener(arg_2_0._btnrootOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnroot:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._showIndex then
		arg_4_0._parentView:removeInstrument(arg_4_0._mo.id)

		return
	end

	arg_4_0._parentView:addInstrument(arg_4_0._mo.id)
end

function var_0_0._btnrootOnClick(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._mo = arg_9_1
	arg_9_0._parentView = arg_9_2
	arg_9_0._txtname.text = arg_9_0._mo.name

	arg_9_0:updateIndex()
	UISpriteSetMgr.instance:setMusicSprite(arg_9_0._imageicon, "v2a4_bakaluoer_freeinstrument_icon_t_" .. arg_9_1.icon)
end

function var_0_0.updateIndex(arg_10_0)
	local var_10_0 = tabletool.indexOf(arg_10_0._parentView._indexList, arg_10_0._mo.id)

	arg_10_0._showIndex = var_10_0 ~= nil

	gohelper.setActive(arg_10_0._imageselectframe, arg_10_0._showIndex)
	gohelper.setActive(arg_10_0._goselect, arg_10_0._showIndex)
	gohelper.setActive(arg_10_0._gounselect, not arg_10_0._showIndex)

	if arg_10_0._showIndex then
		UISpriteSetMgr.instance:setMusicSprite(arg_10_0._imageselectframe, "v2a4_bakaluoer_freeinstrument_set_num" .. var_10_0)
	end

	local var_10_1 = arg_10_0._imageicon.color

	var_10_1.a = arg_10_0._showIndex and 1 or 0.35
	arg_10_0._imageicon.color = var_10_1
	arg_10_0._txtname.color = GameUtil.parseColor(arg_10_0._showIndex and "#ebf0f4" or "#728698")
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
