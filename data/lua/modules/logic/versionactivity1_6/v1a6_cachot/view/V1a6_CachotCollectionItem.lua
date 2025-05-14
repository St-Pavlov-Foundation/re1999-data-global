module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionItem", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1

	arg_1_0:initComponents()
end

function var_0_0.initComponents(arg_2_0)
	arg_2_0._simagecollection = gohelper.findChildSingleImage(arg_2_0.viewGO, "#go_normal/#simage_collection")
	arg_2_0._imageicon = gohelper.findChildImage(arg_2_0.viewGO, "#go_normal/#simage_collection")
	arg_2_0._imageframe = gohelper.findChildImage(arg_2_0.viewGO, "#go_normal/#image_frame")
	arg_2_0._golocked = gohelper.findChild(arg_2_0.viewGO, "#go_locked")
	arg_2_0._gonotget = gohelper.findChild(arg_2_0.viewGO, "#go_notget")
	arg_2_0._gonew = gohelper.findChild(arg_2_0.viewGO, "#go_normal/#go_new")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_click")
	arg_2_0._goselect = gohelper.findChild(arg_2_0.viewGO, "#go_normal/#go_select")
	arg_2_0._canvasgroup = gohelper.onceAddComponent(arg_2_0.viewGO, typeof(UnityEngine.CanvasGroup))
	arg_2_0._anim = gohelper.onceAddComponent(arg_2_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
	arg_3_0:addEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, arg_3_0.onSelect, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
	arg_4_0:removeEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, arg_4_0.onSelect, arg_4_0)
end

function var_0_0._btnclickOnClick(arg_5_0)
	if arg_5_0._mo then
		V1a6_CachotCollectionController.instance:onSelectCollection(arg_5_0._mo.id)
	end
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._mo ~= arg_6_1 then
		arg_6_0._mo = arg_6_1

		UISpriteSetMgr.instance:setV1a6CachotSprite(arg_6_0._imageframe, string.format("v1a6_cachot_img_collectionframe%s", arg_6_0._mo.showRare))

		local var_6_0 = V1a6_CachotCollectionListModel.instance:getCollectionState(arg_6_0._mo.id)

		gohelper.setActive(arg_6_0._gonotget, var_6_0 == V1a6_CachotEnum.CollectionState.UnLocked)
		gohelper.setActive(arg_6_0._golocked, var_6_0 == V1a6_CachotEnum.CollectionState.Locked)

		arg_6_0._simagecollection.curImageUrl = nil

		arg_6_0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. arg_6_0._mo.icon))
		arg_6_0:refreshIconColor(var_6_0)
		arg_6_0:onSelect()
	end

	arg_6_0:playAnim(arg_6_2)
end

var_0_0.IconNormalColor = "#FFFFFF"
var_0_0.IconUnLockColor = "#060606"
var_0_0.IconUnLockAndUnGetColor = "#5C5C5C"
var_0_0.UnLockStateItemAlpha = 0.5
var_0_0.OtherStateItemAlpha = 1

function var_0_0.refreshIconColor(arg_7_0, arg_7_1)
	local var_7_0 = "#FFFFFF"
	local var_7_1 = var_0_0.OtherStateItemAlpha

	if arg_7_1 == V1a6_CachotEnum.CollectionState.UnLocked then
		var_7_0 = var_0_0.IconUnLockAndUnGetColor
		var_7_1 = var_0_0.UnLockStateItemAlpha
	elseif arg_7_1 == V1a6_CachotEnum.CollectionState.Locked then
		var_7_0 = var_0_0.IconUnLockColor
	else
		var_7_0 = var_0_0.IconNormalColor
	end

	arg_7_0._canvasgroup.alpha = var_7_1

	SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._imageicon, var_7_0)
end

function var_0_0.onSelect(arg_8_0)
	local var_8_0 = V1a6_CachotCollectionListModel.instance:getCurSelectCollectionId()
	local var_8_1 = V1a6_CachotCollectionListModel.instance:isCollectionNew(arg_8_0._mo.id)
	local var_8_2 = arg_8_0._mo and arg_8_0._mo.id == var_8_0

	gohelper.setActive(arg_8_0._goselect, var_8_2)
	gohelper.setActive(arg_8_0._gonew, var_8_1)
end

local var_0_1 = 0.06
local var_0_2 = 3

function var_0_0.playAnim(arg_9_0, arg_9_1)
	TaskDispatcher.cancelTask(arg_9_0.delayPlayCollectionOpenAnim, arg_9_0)

	local var_9_0 = V1a6_CachotCollectionListModel.instance:getCurPlayAnimCellIndex()
	local var_9_1 = arg_9_1 and (not var_9_0 or var_9_0 <= arg_9_1 and arg_9_1 <= var_0_2)

	if var_9_1 then
		local var_9_2 = (arg_9_1 - 1) * var_0_1

		TaskDispatcher.runDelay(arg_9_0.delayPlayCollectionOpenAnim, arg_9_0, var_9_2)
		V1a6_CachotCollectionListModel.instance:markCurPlayAnimCellIndex(arg_9_1)
	end

	gohelper.setActive(arg_9_0.viewGO, not var_9_1)
end

function var_0_0.delayPlayCollectionOpenAnim(arg_10_0)
	gohelper.setActive(arg_10_0.viewGO, true)
	arg_10_0._anim:Play("v1a6_cachot_collectionitem_open", 0, 0)
end

function var_0_0.onDestroy(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.delayPlayCollectionOpenAnim, arg_11_0)
	arg_11_0._simagecollection:UnLoadImage()
	arg_11_0:__onDispose()
end

return var_0_0
