module("modules.logic.explore.view.ExploreArchivesView", package.seeall)

local var_0_0 = class("ExploreArchivesView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtChapter = gohelper.findChildTextMesh(arg_1_0.viewGO, "title/txt_title/#txt_chapter")
	arg_1_0._btneasteregg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_easteregg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._content = gohelper.findChild(arg_2_0.viewGO, "#scroll_list/Viewport/Content")
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btneasteregg:AddClickListener(arg_3_0._onEggClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btneasteregg:RemoveClickListener()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._images = {}

	local var_5_0 = arg_5_0.viewParam.id
	local var_5_1 = ExploreSimpleModel.instance:getChapterMo(var_5_0)

	arg_5_0.unLockArchives = var_5_1.archiveIds

	gohelper.setActive(arg_5_0._btneasteregg, var_5_1:haveBonusScene())

	local var_5_2 = lua_explore_story.configDict[var_5_0]

	if not var_5_2 then
		return
	end

	local var_5_3 = ExploreSimpleModel.instance:getNewArchives(var_5_0)
	local var_5_4 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_3) do
		var_5_4[iter_5_1] = true
	end

	arg_5_0._txtChapter.text = DungeonConfig.instance:getChapterCO(var_5_0).name

	ExploreSimpleModel.instance:markArchive(var_5_0, false)

	local var_5_5 = string.format("ui/viewres/explore/explorearchivechapter%d.prefab", var_5_0)
	local var_5_6 = arg_5_0:getResInst(var_5_5, arg_5_0._content).transform

	recthelper.setWidth(arg_5_0._content.transform, recthelper.getWidth(var_5_6))

	arg_5_0._unLockAnims = {}

	for iter_5_2 = 0, var_5_6.childCount - 1 do
		local var_5_7 = var_5_6:GetChild(iter_5_2)
		local var_5_8 = var_5_7.name
		local var_5_9 = string.match(var_5_8, "^#go_item_(%d+)$")

		if var_5_9 then
			arg_5_0:_initArchiveItem(var_5_7, var_5_2[tonumber(var_5_9)], var_5_4)
		end
	end

	local var_5_10 = var_5_6:Find("line")

	if var_5_10 then
		for iter_5_3 = 0, var_5_10.childCount - 1 do
			local var_5_11 = var_5_10:GetChild(iter_5_3)
			local var_5_12 = var_5_11.name
			local var_5_13, var_5_14 = string.match(var_5_12, "^#go_line_(%d+)_(%d+)$")
			local var_5_15 = false

			if var_5_13 and var_5_14 then
				var_5_15 = arg_5_0.unLockArchives[tonumber(var_5_13)] and arg_5_0.unLockArchives[tonumber(var_5_14)]
			else
				local var_5_16, var_5_17 = string.match(var_5_12, "^#go_line_gray_(%d+)_(%d+)$")

				var_5_15 = not arg_5_0.unLockArchives[tonumber(var_5_16)] or not arg_5_0.unLockArchives[tonumber(var_5_17)]
			end

			gohelper.setActive(var_5_11, var_5_15)
		end
	end

	if #arg_5_0._unLockAnims > 0 then
		TaskDispatcher.runDelay(arg_5_0.beginUnlock, arg_5_0, 1.1)
	end
end

function var_0_0._onEggClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.ExploreBonusSceneRecordView, {
		chapterId = arg_6_0.viewParam.id
	})
end

function var_0_0._initArchiveItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1.gameObject
	local var_7_1 = gohelper.getClickWithAudio(var_7_0, AudioEnum.UI.play_ui_feedback_open)
	local var_7_2 = gohelper.findChildSingleImage(var_7_0, "#simage_icon")
	local var_7_3 = gohelper.findChildTextMesh(var_7_0, "#txt_name")
	local var_7_4 = gohelper.findChild(var_7_0, "#go_lock")
	local var_7_5 = gohelper.findChildSingleImage(var_7_0, "#go_lock/#simage_icon")
	local var_7_6 = gohelper.findChild(var_7_0, "go_new")
	local var_7_7 = gohelper.findChild(var_7_0, "#go_lock/lock")
	local var_7_8 = gohelper.findChild(var_7_0, "#go_lock/cn")
	local var_7_9 = gohelper.findChild(var_7_0, "#go_lock/en")
	local var_7_10 = var_7_4:GetComponent(typeof(UnityEngine.Animator))
	local var_7_11 = arg_7_0.unLockArchives[arg_7_2.id] or false
	local var_7_12 = arg_7_3[arg_7_2.id] or false

	gohelper.setActive(var_7_2, var_7_11)
	gohelper.setActive(var_7_3, var_7_11)
	gohelper.setActive(var_7_4, not var_7_11)
	gohelper.setActive(var_7_6, var_7_12)

	var_7_3.text = arg_7_2.title

	var_7_2:LoadImage(ResUrl.getExploreBg("file/" .. arg_7_2.res))
	var_7_5:LoadImage(ResUrl.getExploreBg("file/" .. arg_7_2.res))
	table.insert(arg_7_0._images, var_7_2)
	table.insert(arg_7_0._images, var_7_5)

	if var_7_11 then
		arg_7_0._goNew = arg_7_0._goNew or arg_7_0:getUserDataTb_()
		arg_7_0._goNew[arg_7_2.id] = var_7_6

		arg_7_0:addClickCb(var_7_1, arg_7_0._onItemClick, arg_7_0, arg_7_2.id)
	end

	if var_7_12 then
		gohelper.setActive(var_7_4, true)
		gohelper.setActive(var_7_3, false)
		gohelper.setActive(var_7_6, false)
		table.insert(arg_7_0._unLockAnims, {
			var_7_4,
			var_7_10,
			var_7_3,
			var_7_2,
			var_7_6,
			var_7_7,
			var_7_8,
			var_7_9
		})
	end
end

function var_0_0.beginUnlock(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._unLockAnims) do
		iter_8_1[2]:Play("unlock", 0, 0)
		gohelper.setActive(iter_8_1[6], false)
		gohelper.setActive(iter_8_1[7], false)
		gohelper.setActive(iter_8_1[8], false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	TaskDispatcher.runDelay(arg_8_0.unlockEnd, arg_8_0, 1)
end

function var_0_0.unlockEnd(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._unLockAnims) do
		gohelper.setActive(iter_9_1[1], false)
		gohelper.setActive(iter_9_1[3], true)
		gohelper.setActive(iter_9_1[4], true)
		gohelper.setActive(iter_9_1[5], true)

		if not arg_9_0._tweens then
			arg_9_0._tweens = {}
		end

		local var_9_0 = ZProj.TweenHelper.DoFade(iter_9_1[3], 0, 1, 0.5)

		table.insert(arg_9_0._tweens, var_9_0)
	end
end

function var_0_0._onItemClick(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goNew[arg_10_1], false)
	ViewMgr.instance:openView(ViewName.ExploreArchivesDetailView, {
		id = arg_10_1,
		chapterId = arg_10_0.viewParam.id
	})
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.beginUnlock, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.unlockEnd, arg_11_0)

	for iter_11_0, iter_11_1 in pairs(arg_11_0._images) do
		iter_11_1:UnLoadImage()
	end

	if arg_11_0._tweens then
		for iter_11_2, iter_11_3 in pairs(arg_11_0._tweens) do
			ZProj.TweenHelper.KillById(iter_11_3)
		end

		arg_11_0._tweens = nil
	end
end

return var_0_0
