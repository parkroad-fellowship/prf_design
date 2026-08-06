import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/_index.dart';

/// Full chat screen scaffold with navbar, message list and composer.
///
/// Combines a [PRFNavBar] header, a scrollable list of [messages] rendered via
/// [messageBuilder], and a fixed [composer] at the bottom. Shows a loading
/// indicator while [loading], or an empty state when there are no messages.
///
/// Example:
/// ```dart
/// PRFChatView<ChatMessage>(
///   title: 'Mission chat',
///   messages: messages,
///   messageBuilder: (context, message, index) =>
///       PRFMessageBubble(message: message),
///   composer: PRFReplyComposer(
///     controller: _replyController,
///     hintText: 'Reply…',
///     isComposing: _hasText,
///     isLoading: _sending,
///     onSend: _send,
///   ),
///   onBack: () => Navigator.pop(context),
/// )
/// ```
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

  /// Title shown in the nav bar.
  final String title;

  /// The messages to render.
  final List<T> messages;

  /// Builds the visual for each message.
  final Widget Function(BuildContext context, T message, int index)
  messageBuilder;

  /// Widget pinned below the list (e.g. a [PRFReplyComposer]).
  final Widget composer;

  /// Invoked when the nav-bar back button is pressed.
  final VoidCallback? onBack;

  /// Overrides the nav-bar background colour.
  final Color? navBarBackgroundColor;

  /// Scroll controller for the message list.
  final ScrollController? scrollController;

  /// When true a loading indicator replaces the list.
  final bool loading;

  /// Headline of the empty state shown when there are no messages.
  final String? emptyLabel;

  /// Description of the empty state shown when there are no messages.
  final String? emptyDescription;

  /// Extra widget appended below the list.
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
