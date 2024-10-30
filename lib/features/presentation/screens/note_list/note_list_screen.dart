import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:noteapp/core/constants/app_colors.dart';
import 'package:noteapp/core/constants/app_strings.dart';
import 'package:noteapp/core/routes/app_routes.dart';
import 'package:noteapp/core/utility/app_utility.dart';
import 'package:noteapp/features/domain/enum/action_type.dart';
import 'package:noteapp/features/domain/model/action_param_model.dart';
import 'package:noteapp/features/domain/model/note_model.dart';
import 'package:noteapp/features/presentation/components/app_button.dart';
import 'package:noteapp/features/presentation/components/app_scaffold.dart';
import 'package:noteapp/features/presentation/screens/note_list/bloc/note_list_bloc.dart';
import 'package:noteapp/features/presentation/screens/note_list/bloc/note_list_state.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const _HeaderTitle(),
        actions: const [
          _HeaderAction(),
        ],
      ),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        builder: (context, state) {
          if (state is NoteListLoadingState) {
            return const _LoadingView();
          } else if (state is NoteListErrorState) {
            return const _ErrorView();
          } else if (state is NoteListLoadedState) {
            return const _NoteListView();
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.push(
              AppRoutes.addEditNote,
              extra: const ActionParamModel(
                actionType: ActionType.add,
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: AppColors.greenColor,
            size: 30.h, // Customize the size
          ),
        ),
      ),
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  const _HeaderTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.noteList,
      style: TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        height: 30.h,
        width: 30.h,
        child: CircularProgressIndicator(
          color: AppColors.blueColor,
          strokeWidth: 3.w,
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NoteListBloc>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<NoteListBloc, NoteListState>(
            builder: (context, state) {
              if (state is NoteListErrorState) {
                return Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          SizedBox(height: 10.h),
          AppButton(
            width: 100.w,
            onPressed: bloc.getNoteList,
            text: AppStrings.retry,
          ),
        ],
      ),
    );
  }
}

class _NoteListView extends StatelessWidget {
  const _NoteListView();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Stack(
        children: [
          BlocBuilder<NoteListBloc, NoteListState>(
            builder: (context, state) {
              if (state is NoteListLoadedState) {
                final list = state.noteList;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.messageNoDataFound,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }
                return Scrollbar(
                  child: ListView.separated(
                    separatorBuilder: (context, i) {
                      return SizedBox(height: 5.h);
                    },
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final data = list[i];
                      return _ListItemView(
                        itemIndex: i,
                        data: data,
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class _ListItemView extends StatelessWidget {
  final int itemIndex;
  final NoteModel data;

  const _ListItemView({
    required this.itemIndex,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.h,
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        color: Colors.white,
        elevation: 2,
        child: Material(
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              context.push(
                AppRoutes.addEditNote,
                extra: ActionParamModel(
                  actionType: ActionType.view,
                  data: data,
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    if (data.createdAt != null)
                      Text(
                        AppUtility.formatDateTime(data.createdAt!),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.gray700,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
