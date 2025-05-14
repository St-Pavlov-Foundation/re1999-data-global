module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionGetView", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionGetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_lineitem/#go_collectionitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._golineitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_lineitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goScrollContent = gohelper.findChild(arg_5_0.viewGO, "#scroll_view/Viewport/Content")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam
	local var_7_1 = var_7_0 and var_7_0.getColletions
	local var_7_2 = arg_7_0:buildLineMOList(var_7_1)

	arg_7_0:refreshPerLineCollectionList(var_7_2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_collection_get)
end

local var_0_1 = 3

function var_0_0.buildLineMOList(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if arg_8_1 then
		local var_8_1 = 0
		local var_8_2 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			if var_8_1 >= var_0_1 then
				table.insert(var_8_0, var_8_2)

				var_8_2 = {}
				var_8_1 = 0
			end

			table.insert(var_8_2, iter_8_1)

			var_8_1 = var_8_1 + 1
		end

		if var_8_2 and #var_8_2 > 0 then
			table.insert(var_8_0, var_8_2)
		end
	end

	return var_8_0
end

function var_0_0.refreshPerLineCollectionList(arg_9_0, arg_9_1)
	gohelper.CreateObjList(arg_9_0, arg_9_0._onShowPerLineCollectionItem, arg_9_1, arg_9_0._goScrollContent, arg_9_0._golineitem)
end

function var_0_0._onShowPerLineCollectionItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0:refreshGetCollectionList(arg_10_2, arg_10_1, arg_10_0._gocollectionitem)
end

function var_0_0.refreshGetCollectionList(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	gohelper.CreateObjList(arg_11_0, arg_11_0._onShowGetCollectionItem, arg_11_1, arg_11_2, arg_11_3)
end

function var_0_0._onShowGetCollectionItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_12_2)

	if var_12_0 then
		local var_12_1 = gohelper.findChildSingleImage(arg_12_1, "collection/#simage_collection")
		local var_12_2 = gohelper.findChildText(arg_12_1, "collection/#txt_name")
		local var_12_3 = gohelper.findChild(arg_12_1, "layout")
		local var_12_4 = gohelper.findChild(arg_12_1, "layout/#go_descitem")

		var_12_1.curImageUrl = nil

		var_12_1:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_12_0.icon))

		var_12_2.text = var_12_0.name

		V1a6_CachotCollectionHelper.refreshSkillDescWithoutEffectDesc(var_12_0, var_12_3, var_12_4)
	end
end

function var_0_0.onClose(arg_13_0)
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.GetCollecttions)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
