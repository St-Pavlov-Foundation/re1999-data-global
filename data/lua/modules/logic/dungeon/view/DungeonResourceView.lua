module("modules.logic.dungeon.view.DungeonResourceView", package.seeall)

local var_0_0 = class("DungeonResourceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageresourcebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_resource/#simage_resourcebg")
	arg_1_0._simagerebottommaskbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_resource/#simage_bottommaskbg")
	arg_1_0._simagedrawbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_resource/#simage_drawbg")
	arg_1_0._gorescontent = gohelper.findChild(arg_1_0.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent")
	arg_1_0._scrollchapterresource = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource")

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
	arg_4_0._itemList = arg_4_0:getUserDataTb_()
	arg_4_0._width = 777
	arg_4_0._space = 35

	arg_4_0:addEventCb(DungeonController.instance, DungeonEvent.OnShowResourceView, arg_4_0._OnShowResourceView, arg_4_0)
	arg_4_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_4_0._OnActStateChange, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0._OnActStateChange(arg_6_0)
	arg_6_0._index = 1

	local var_6_0 = DungeonChapterListModel.instance:getFbList()

	arg_6_0:addChapterItem(var_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._itemList) do
		if iter_6_0 >= arg_6_0._index then
			gohelper.setActive(iter_6_1.viewGO, false)
		end
	end
end

function var_0_0._OnShowResourceView(arg_7_0)
	arg_7_0._index = 1

	arg_7_0._simageresourcebg:LoadImage(ResUrl.getDungeonIcon("full/bg123"))
	arg_7_0._simagerebottommaskbg:LoadImage(ResUrl.getDungeonIcon("bg_down"))
	arg_7_0._simagedrawbg:LoadImage(ResUrl.getDungeonIcon("qianbihua"))

	local var_7_0 = DungeonChapterListModel.instance:getFbList()

	arg_7_0:addChapterItem(var_7_0)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._itemList) do
		if iter_7_0 >= arg_7_0._index then
			gohelper.setActive(iter_7_1.viewGO, false)
		end
	end
end

function var_0_0.addChapterItem(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		arg_8_0:getChapterItem(arg_8_0._index):updateParam(iter_8_1)

		arg_8_0._index = arg_8_0._index + 1
	end

	local var_8_0 = #arg_8_1
	local var_8_1 = var_8_0 >= 3

	recthelper.setWidth(arg_8_0._gorescontent.transform, (var_8_1 and var_8_0 or 0) * (arg_8_0._width + arg_8_0._space))

	if var_8_1 then
		arg_8_0._scrollchapterresource.movementType = 1
	else
		arg_8_0._scrollchapterresource.movementType = 2
	end
end

function var_0_0.getChapterItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._itemList[arg_9_1]

	if not var_9_0 then
		local var_9_1 = arg_9_0.viewContainer:getSetting().otherRes[2]
		local var_9_2 = arg_9_0:getResInst(var_9_1, arg_9_0._gorescontent, "chapteritem" .. arg_9_1)
		local var_9_3 = 391 + (arg_9_1 - 1) * (arg_9_0._width + arg_9_0._space)
		local var_9_4 = -237.5

		recthelper.setAnchor(var_9_2.transform, var_9_3, var_9_4)

		var_9_0 = DungeonResChapterItem.New()

		var_9_0:initView(var_9_2)

		arg_9_0._itemList[arg_9_1] = var_9_0
	end

	gohelper.setActive(var_9_0.viewGO, true)

	local var_9_5 = gohelper.findChild(var_9_0.viewGO, "anim")
	local var_9_6 = var_9_5 and var_9_5:GetComponent(typeof(UnityEngine.Animation))

	if var_9_6 then
		var_9_6:Play()
	end

	return var_9_0
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._itemList) do
		iter_10_1:destroyView()
	end

	arg_10_0._simageresourcebg:UnLoadImage()
	arg_10_0._simagerebottommaskbg:UnLoadImage()
	arg_10_0._simagedrawbg:UnLoadImage()
end

return var_0_0
