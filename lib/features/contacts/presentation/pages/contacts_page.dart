import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactsBloc>(context).add(FetchContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: BlocListener<ContactsBloc, ContactsState>(
        listener: (context, state) async {
          final contactsBloc = BlocProvider.of<ContactsBloc>(context);

          if (state is ConversationReady) {
            var res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ChatPage(
                      conversationId: state.conversationId,
                      mate: state.contactName,
                    ),
              ),
            );

            if (res == null) {
              contactsBloc.add(FetchContacts());
            }
          } else if (state is ContastAdded) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Contacts Added')));
          } else if (state is ContastAddedFailed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ContactsLoaded) {
              return ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  return ListTile(
                    title: Text(
                      contact.username,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      contact.email,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      BlocProvider.of<ContactsBloc>(context).add(
                        CheckOrCreateConversation(
                          contactName: contact.username,
                          contactId: contact.id,
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is ContactsError) {
              return Center(child: Text(state.message));
            }

            return Center(child: Text('No contacts found'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Add contact',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            content: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter contact email',
                hintStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  if (email.isNotEmpty) {
                    BlocProvider.of<ContactsBloc>(
                      context,
                    ).add(AddContact(email: email));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Add',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
    );
  }
}
