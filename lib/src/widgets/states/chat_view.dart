import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/_index.dart';
import 'package:prf_design/src/widgets/navigation/_index.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class PRFChatView<T> extends StatelessWidget {
  const PRFChatView({
    required this.title,
    required this.messages,
    required this.messageBuilder,
    required this.composer,
    super.key,
    this.onBack,
    this.navBarBackgroundColor,
    this.scrollController,
    this.loading = false,
    this.emptyLabel,
    this.emptyDescription,
    this.bottomSpacing = const SizedBox(height: PRFSpacingTokens.lg),
  });

  final String title;
  final List<T> messages;
  final Widget Function(BuildContext context, T message, int index)
  messageBuilder;
  final Widget composer;
  final VoidCallback? onBack;
  final Color? navBarBackgroundColor;
  final ScrollController? scrollController;
  final bool loading;
  final String? emptyLabel;
  final String? emptyDescription;
  final Widget bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  PRFNavBar(
                    title: title,
                    onBack: onBack,
                    backgroundColor:
                        navBarBackgroundColor ?? theme.colorScheme.surface,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: PRFSpacingTokens.lg),
                  ),
                  if (loading)
                    const SliverFillRemaining(
                      child: Center(
                        child: PRFCircularProgressIndicator(),
                      ),
                    )
                  else if (messages.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: PRFEmptyView(
                          label: emptyLabel ?? 'No messages',
                          description: emptyDescription ?? 'Please wait',
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final message = messages[index];
                          return messageBuilder(context, message, index);
                        },
                        childCount: messages.length,
                      ),
                    ),
                  SliverToBoxAdapter(child: bottomSpacing),
                ],
              ),
            ),
            composer,
          ],
        ),
      ),
    );
  }
}
