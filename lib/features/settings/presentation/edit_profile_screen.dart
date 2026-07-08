import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/update_user_usecase.dart';
import 'package:gamespotlight/core/providers/auth/auth_provider.dart';
import 'package:gamespotlight/core/utils/validators.dart';
import 'package:gamespotlight/core/widgets/async_ui_builder.dart';
import 'package:gamespotlight/core/widgets/tv_button.dart';
import 'package:gamespotlight/core/widgets/tv_text_field.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // 1. Inicializar los controladores vacíos
  final _usernameController = TextEditingController();
  final _avatarUrlController = TextEditingController();
  final _countryController = TextEditingController();

  // 2. Bandera de control para autorellenar solo la primera vez
  bool _isDataLoaded = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _avatarUrlController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final userAsyncValue = ref.watch(meProvider);

    ref.listen<AsyncValue<void>>(updateProvider, (_, state) {
      state.whenOrNull(
        error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString()), backgroundColor: cs.error),
        ),
      );
    });

    final isLoading = ref.watch(updateProvider).isLoading;

    return Scaffold(
      appBar: AppBar(),
      body: AsyncUIBuilder(
        asyncValue: userAsyncValue,
        builder: (data) {
          if (!_isDataLoaded) {
            _usernameController.text = data.name ?? '';
            _avatarUrlController.text = data.avatarUrl ?? '';
            _countryController.text = data.country ?? '';
            _isDataLoaded = true;
          }

          final textFields = [
            _buildUsernamelField(),
            _buildStateField(),
            _buildAvatarUrlField(),
          ];

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 20.0,
                ),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      _buildTitle(),
                      const SliverToBoxAdapter(child: SizedBox(height: 30)),
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 16,
                              mainAxisExtent: 90,
                            ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return textFields[index];
                        }, childCount: textFields.length),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 40)),
                      SliverToBoxAdapter(child: _buildSubmitButton(isLoading)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle() {
    return const SliverToBoxAdapter(
      child: Text(
        'EDITAR PERFIL',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 28,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildUsernamelField() {
    return TvTextField(
      controller: _usernameController,
      label: 'Usuario',
      hint: 'Ingrese su nombre de usuario',
      prefixIcon: const Icon(Icons.person_outline),
      autofocus: true,
    );
  }

  Widget _buildAvatarUrlField() {
    return TvTextField(
      controller: _avatarUrlController,
      label: 'URL del Avatar',
      hint: 'https://ejemplo.com/avatar.png',
      prefixIcon: const Icon(Icons.image_outlined),
      validator: Validators.compose([Validators.url(message: 'URL inválida')]),
    );
  }

  Widget _buildStateField() {
    return TvTextField(
      controller: _countryController,
      label: 'Estado',
      hint: 'Escriba el estado donde vive (Ejmp. Mexico)',
      prefixIcon: const Icon(Icons.chat_bubble_outline),
    );
  }

  // Se añadió el parámetro isLoading para pasarlo al TvButton
  Widget _buildSubmitButton(bool isLoading) {
    return Center(
      child: SizedBox(
        width: 320,
        height: 52,
        child: TvButton(
          label: 'GUARDAR CAMBIOS',
          icon: Icons.save_outlined,
          isLoading: isLoading,
          onPressed: _validateAndSubmit,
        ),
      ),
    );
  }

  void _validateAndSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final entity = UpdateUserParams(
      username: _usernameController.text,
      country: _countryController.text,
      avatarUrl: _avatarUrlController.text,
    );

    ref.read(updateProvider.notifier).call(entity);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Cambios guardados'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );

    context.pop();
  }
}
