module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionView", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_title")
	arg_1_0._simagetitleicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_titleicon")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#scroll_view")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_view/Viewport/Content/#go_collectionitem")
	arg_1_0._gocollectionsort = gohelper.findChild(arg_1_0.viewGO, "left/#go_collectionsort")
	arg_1_0._btnall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#go_collectionsort/#btn_all")
	arg_1_0._btnhasget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#go_collectionsort/#btn_hasget")
	arg_1_0._btnunget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#go_collectionsort/#btn_unget")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#go_collectioninfo/#simage_collection")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "right/#go_collectioninfo/#go_lock")
	arg_1_0._gounget = gohelper.findChild(arg_1_0.viewGO, "right/#go_collectioninfo/#go_unget")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget")
	arg_1_0._gogrid1 = gohelper.findChild(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid1")
	arg_1_0._simageget1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid1/#simage_get1")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid1/#simage_get1/#simage_icon1")
	arg_1_0._gogrid2 = gohelper.findChild(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid2")
	arg_1_0._simageget2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid2/#simage_get2")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid2/#simage_get2/#simage_icon2")
	arg_1_0._gounique = gohelper.findChild(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/#go_unique")
	arg_1_0._txtuniquetips = gohelper.findChildText(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/#go_unique/#txt_uniquetips")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer/Viewport/Content/descontainer/#txt_desc")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "right/#go_collectioninfo/#txt_name")
	arg_1_0._scrolleffectcontainer = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer")
	arg_1_0._goskillcontainer = gohelper.findChild(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer/Viewport/Content/#go_skillcontainer")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer/Viewport/Content/#go_skillcontainer/#go_descitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtunlocktask = gohelper.findChildText(arg_1_0.viewGO, "right/#go_collectioninfo/#go_lock/#txt_unlocktask")
	arg_1_0._gocollectioninfo = gohelper.findChild(arg_1_0.viewGO, "right/#go_collectioninfo")
	arg_1_0._goscrollempty = gohelper.findChild(arg_1_0.viewGO, "left/#go_scrollempty")
	arg_1_0._gocollectionempty = gohelper.findChild(arg_1_0.viewGO, "right/#go_collectionempty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnall:AddClickListener(arg_2_0._btnallOnClick, arg_2_0)
	arg_2_0._btnhasget:AddClickListener(arg_2_0._btnhasgetOnClick, arg_2_0)
	arg_2_0._btnunget:AddClickListener(arg_2_0._btnungetOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnall:RemoveClickListener()
	arg_3_0._btnhasget:RemoveClickListener()
	arg_3_0._btnunget:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnallOnClick(arg_4_0)
	V1a6_CachotCollectionController.instance:onSwitchCategory(V1a6_CachotEnum.CollectionCategoryType.All)
end

function var_0_0._btnhasgetOnClick(arg_5_0)
	V1a6_CachotCollectionController.instance:onSwitchCategory(V1a6_CachotEnum.CollectionCategoryType.HasGet)
end

function var_0_0._btnungetOnClick(arg_6_0)
	V1a6_CachotCollectionController.instance:onSwitchCategory(V1a6_CachotEnum.CollectionCategoryType.UnGet)
end

function var_0_0._btncloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0:addEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, arg_8_0.refreshCollectionInfo, arg_8_0)
	arg_8_0:addEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSwitchCategory, arg_8_0.switchCategory, arg_8_0)

	arg_8_0._imagecollectionicon = gohelper.findChildImage(arg_8_0.viewGO, "right/#go_collectioninfo/#simage_collection")
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

local var_0_1 = 4

function var_0_0.onOpen(arg_10_0)
	V1a6_CachotCollectionController.instance:onOpenView(V1a6_CachotEnum.CollectionCategoryType.All, var_0_1)
end

var_0_0.IconUnLockColor = "#FFFFFF"
var_0_0.IconLockColor = "#060606"
var_0_0.IconUnLockAlpha = 1
var_0_0.IconLockAlpha = 0.7

function var_0_0.refreshCollectionInfo(arg_11_0)
	local var_11_0 = V1a6_CachotCollectionListModel.instance:getCurSelectCollectionId()

	gohelper.setActive(arg_11_0._gocollectioninfo, var_11_0 ~= nil)
	gohelper.setActive(arg_11_0._gocollectionempty, var_11_0 == nil)
	gohelper.setActive(arg_11_0._goscrollempty, var_11_0 == nil)

	if var_11_0 then
		local var_11_1 = V1a6_CachotCollectionListModel.instance:getCollectionState(var_11_0)
		local var_11_2 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_11_0)

		gohelper.setActive(arg_11_0._gohasget, var_11_1 == V1a6_CachotEnum.CollectionState.HasGet or var_11_1 == V1a6_CachotEnum.CollectionState.New)
		gohelper.setActive(arg_11_0._golock, var_11_1 == V1a6_CachotEnum.CollectionState.Locked)
		gohelper.setActive(arg_11_0._gounget, var_11_1 == V1a6_CachotEnum.CollectionState.UnLocked)
		gohelper.setActive(arg_11_0._txtname, var_11_1 ~= V1a6_CachotEnum.CollectionState.Locked)

		if var_11_2 and var_11_1 then
			local var_11_3 = var_0_0.IconUnLockColor
			local var_11_4 = var_0_0.IconUnLockAlpha

			if var_11_1 == V1a6_CachotEnum.CollectionState.Locked then
				arg_11_0:onCollectionLockedState(var_11_2)

				var_11_3 = var_0_0.IconLockColor
				var_11_4 = var_0_0.IconLockAlpha
			elseif var_11_1 == V1a6_CachotEnum.CollectionState.UnLocked then
				arg_11_0:onCollectionUnLockedState(var_11_2)
			else
				arg_11_0:onCollectionHasGetState(var_11_2)
			end

			arg_11_0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_11_2.icon))
			SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._imagecollectionicon, var_11_3)
			ZProj.UGUIHelper.SetColorAlpha(arg_11_0._imagecollectionicon, var_11_4)
		end
	end
end

function var_0_0.onCollectionLockedState(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.unlockTask
	local var_12_1 = lua_rogue_collecion_unlock_task.configDict[var_12_0]

	arg_12_0._txtunlocktask.text = var_12_1 and var_12_1.desc or ""
end

function var_0_0.onCollectionUnLockedState(arg_13_0, arg_13_1)
	arg_13_0._txtname.text = tostring(arg_13_1.name)
end

function var_0_0.onCollectionHasGetState(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._gohasget, true)

	arg_14_0._txtname.text = tostring(arg_14_1.name)
	arg_14_0._txtdesc.text = tostring(arg_14_1.desc)

	gohelper.setActive(arg_14_0._gogrid1, arg_14_1.holeNum >= 1)
	gohelper.setActive(arg_14_0._gogrid2, arg_14_1.holeNum >= 2)
	V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(arg_14_1, arg_14_0._txtuniquetips, arg_14_0._gounique)
	V1a6_CachotCollectionHelper.refreshSkillDesc(arg_14_1, arg_14_0._goskillcontainer, arg_14_0._godescitem, arg_14_0._refreshSingleSkillDesc, arg_14_0._refreshSingleEffectDesc, arg_14_0)
end

local var_0_2 = "#6F3C0F"
local var_0_3 = "#2B4E6C"

function var_0_0._refreshSingleSkillDesc(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = lua_rule.configDict[arg_15_2]

	if var_15_0 then
		gohelper.findChildText(arg_15_1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(var_15_0.desc, var_0_2, var_0_3)
	end
end

function var_0_0._refreshSingleEffectDesc(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = SkillConfig.instance:getSkillEffectDescCo(arg_16_2)

	if var_16_0 then
		local var_16_1 = gohelper.findChildText(arg_16_1, "txt_desc")
		local var_16_2 = string.format("[%s]:%s", var_16_0.name, var_16_0.desc)

		var_16_1.text = HeroSkillModel.instance:skillDesToSpot(var_16_2, var_0_2, var_0_3)
	end
end

function var_0_0.switchCategory(arg_17_0)
	local var_17_0 = V1a6_CachotCollectionListModel.instance:getCurCategory()

	arg_17_0:refreshCategoryUI(arg_17_0._btnall.gameObject, var_17_0 == V1a6_CachotEnum.CollectionCategoryType.All)
	arg_17_0:refreshCategoryUI(arg_17_0._btnhasget.gameObject, var_17_0 == V1a6_CachotEnum.CollectionCategoryType.HasGet)
	arg_17_0:refreshCategoryUI(arg_17_0._btnunget.gameObject, var_17_0 == V1a6_CachotEnum.CollectionCategoryType.UnGet)

	arg_17_0._scrollview.verticalNormalizedPosition = 1
end

function var_0_0.refreshCategoryUI(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 then
		local var_18_0 = gohelper.findChild(arg_18_1, "btn1")
		local var_18_1 = gohelper.findChild(arg_18_1, "btn2")

		gohelper.setActive(var_18_1, arg_18_2)
		gohelper.setActive(var_18_0, not arg_18_2)
	end
end

function var_0_0.onClose(arg_19_0)
	arg_19_0:removeEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, arg_19_0.refreshCollectionInfo, arg_19_0)
	arg_19_0:removeEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSwitchCategory, arg_19_0.switchCategory, arg_19_0)
	V1a6_CachotCollectionController.instance:onCloseView()
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0._simagecollection:UnLoadImage()
end

return var_0_0
